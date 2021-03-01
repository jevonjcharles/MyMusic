//
//  UserTokenViewModel.swift
//  MyMusic
//
//  Created by Jevon Charles on 2/26/21.
//

import Foundation
import Combine
import StoreKit



class MusicKitViewModel: ObservableObject {
	private var cancellables = Set<AnyCancellable>()
	private var userToken: String?
	private weak var alertViewModel: AlertViewModel?
	private var countryCode: String?

	private var userTokenFuture = Future<String, Error> { promise in
		let controller = SKCloudServiceController()
		controller.requestUserToken(forDeveloperToken: developerToken) { userToken, error in
			if let error = error {
				promise(.failure(error))
			}

			if let userToken = userToken {
				promise(.success(userToken))
			}
		}
	}

	private var countryCodeFuture = Future<String, Error> { promise in
		let controller = SKCloudServiceController()
		controller.requestStorefrontCountryCode { countryCode, error in
			if let error = error {
				promise(.failure(error))
			}

			if let countryCode = countryCode {
				promise(.success(countryCode))
			}
		}
	}

	init(alertViewModel: AlertViewModel) {
		self.alertViewModel = alertViewModel

		requestAuthorization()
			.receive(on: RunLoop.main)
			.sink {[weak self] (status) in
				guard let self = self else { return }
				switch status {
					case .notDetermined: self.alertViewModel?.present(title: "Undetermined Authorization", message: "Please check internet capabilities")
					case .denied: self.alertViewModel?.present(title: "Denied", message: "Please check with Apple")
					case .restricted: self.alertViewModel?.present(title: "restricted", message: "Please check with Apple")
					case .authorized: break
					@unknown default: self.alertViewModel?.present(title: "Unknown", message: "Sorry unknown failure has acquired")
				}
			}.store(in: &cancellables)

		userTokenFuture
			.receive(on: DispatchQueue.main)
			.sink(receiveCompletion: {[weak self] completion in
				guard let self = self else { return }
				switch completion {
					case .finished: break
					case .failure(let error): self.alertViewModel?.present(title: error.localizedDescription)
				}
			}, receiveValue: {[weak self] userToken in
				guard let self = self else { return }
				self.userToken = userToken

				self.recentlyAdded()
					.sink(receiveCompletion: { completion in
						switch completion {
							case .failure(let error): print(error)
							case .finished: break
						}
					}, receiveValue: { items in
						print(items.count)
					})
					.store(in: &self.cancellables)

			})
			.store(in: &cancellables)

		countryCodeFuture
			.receive(on: RunLoop.main)
			.sink(receiveCompletion: {[weak self] completion in
				guard let self = self else { return }
				switch completion {
					case .finished: break
					case .failure(let error): self.alertViewModel?.present(title: error.localizedDescription)
				}
			}, receiveValue: {[weak self] countryCode in
				guard let self = self else { return }
				self.countryCode = countryCode
			})
			.store(in: &cancellables)
	}

	private func requestAuthorization() -> Future<SKCloudServiceAuthorizationStatus, Never> {
		return Future { promise in
			SKCloudServiceController.requestAuthorization { status in
				promise(.success(status))
			}
		}
	}

	// https://api.music.apple.com/v1/me/library/recently-added
	private func recentlyAdded() -> AnyPublisher<[History], Error> {
		APIHelper.call(.recentlyAdded, with: userToken!, limit: 60)
			.receive(on: RunLoop.main)
			.eraseToAnyPublisher()
	}
}

enum EndPoint {
	static let scheme = "https"
	static let host = "api.music.apple.com"

	case recentlyAdded

	func requestWith(_ userToken: String) -> URLRequest {
		switch self {
			case .recentlyAdded:
				var components = URLComponents()
				components.scheme = EndPoint.scheme
				components.host = EndPoint.host
				components.path = "/v1/me/library/recently-added"
				components.queryItems = [
					URLQueryItem(name: "limit", value: "25")
				]

				var request = URLRequest(url: components.url!)
				request.setValue("Bearer \(developerToken)", forHTTPHeaderField: "Authorization")
				request.setValue(userToken, forHTTPHeaderField: "Music-User-Token")
				return request
		}
	}
}

struct APIHelper {
	private static func call<T: Decodable>(_ endPoint: EndPoint, times: Int, with userToken: String) -> AnyPublisher<Response<T>, Error> {
		URLSession.shared.dataTaskPublisher(for: endPoint.requestWith(userToken))
			.map(\.data)
			.decode(type: Payload<T>.self, decoder: JSONDecoder())
			.map(\.items)
			.map { items in
				let nextIndex = times - 1
				if nextIndex != 0 {
					return Response(items: items, nextIndex: nextIndex)
				} else {
					return Response(hasMorePages: false, items: items)
				}
			}
			.eraseToAnyPublisher()
	}

	static func call<T: Decodable>(_ endPoint: EndPoint, with userToken: String, limit maxCount: Int) -> AnyPublisher<[T], Error> {
		let indexPublisher = CurrentValueSubject<Int, Never>((maxCount / 25) + 1)

		return indexPublisher
			.flatMap { index in
				return self.call(endPoint, times: index, with: userToken)
			}
			.handleEvents(receiveOutput: { (response: Response) in
				if response.hasMorePages {
					indexPublisher.send(response.nextIndex)
				} else {
					indexPublisher.send(completion: .finished)
				}
			})
			.reduce([T](), { allItems, response in
				return Array((response.items + allItems).prefix(maxCount))
			})
			.eraseToAnyPublisher()

//		URLSession.shared.dataTaskPublisher(for: endPoint.requestWith(userToken))
//			.map(\.data)
//			.map { data in
//				do {
//					if let json = try JSONSerialization.jsonObject(with: data, options: []) as? [String: Any] {
//						print(json)
//					}
//				} catch let error as NSError {
//					print(error.localizedDescription)
//				}
//
//				return data
//			}
//			.decode(type: T.self, decoder: JSONDecoder())
//			.eraseToAnyPublisher()
	}
}

struct Response<T: Decodable>{
	var hasMorePages = true
	var items: [T]
	var nextIndex = 0
}
