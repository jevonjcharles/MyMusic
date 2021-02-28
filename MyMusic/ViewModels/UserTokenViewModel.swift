//
//  UserTokenViewModel.swift
//  MyMusic
//
//  Created by Jevon Charles on 2/26/21.
//

import Foundation
import Combine
import StoreKit



class UserTokenViewModel: ObservableObject {
	@Published var userToken: String?
	@Published var isNotAuthorized: Bool = false

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
	private var cancellables = Set<AnyCancellable>()
	
	private weak var alertViewModel: AlertViewModel?

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

	private func requestUserToken() {
//		userTokenFuture = Future<String, Error> {[weak self] completion in
//			guard let self = self else { return }
//			let controller = SKCloudServiceController()
//			controller.requestUserToken(forDeveloperToken: self.developerToken) { userToken, error in
//				if let error = error {
//					completion(.failure(error))
//				}
//
//				if let userToken = userToken {
//					completion(.success(userToken))
//				}
//			}
//		}
//
//		if let userTokenFuture = userTokenFuture {
//			userTokenFuture
//				.sink(receiveCompletion: { completion in
//					self.tokenError = completion as! Error
//				}, receiveValue: <#T##((String) -> Void)##((String) -> Void)##(String) -> Void#>)
//		}
	}
//	private func userTokenFuture() -> Future <String, Error> {
//		return Future() { promise in
//			SKCloudServiceController().requestUserToken(forDeveloperToken: self.developerToken) { (userToken: String?, error: Error?) in
//
//			}
//		}
//	}
}
