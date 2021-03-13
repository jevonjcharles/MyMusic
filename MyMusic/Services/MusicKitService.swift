//
//  UserTokenViewModel.swift
//  MyMusic
//
//  Created by Jevon Charles on 2/26/21.
//

import Foundation
import Combine
import StoreKit

struct MediaPlayerService {
	
}
//	private var cancellables = Set<AnyCancellable>()
//	private var userToken: String?
//	private weak var alertViewModel: AlertViewModel?
//	private var countryCode: String?
//
//	private var countryCodeFuture = Future<String, Error> { promise in
//
//	}
//
//	init(alertViewModel: AlertViewModel) {
//		self.alertViewModel = alertViewModel
//
//		requestAuthorization()
//			.receive(on: RunLoop.main)
//			.sink {[weak self] status in
//				guard let self = self else { return }
//				switch status {
//					case .notDetermined: self.alertViewModel?.present(title: "Undetermined Authorization", message: "Please check internet capabilities")
//					case .denied: self.alertViewModel?.present(title: "Denied", message: "Please check with Apple")
//					case .restricted: self.alertViewModel?.present(title: "restricted", message: "Please check with Apple")
//					case .authorized: break
//					@unknown default: self.alertViewModel?.present(title: "Unknown", message: "Sorry unknown failure has acquired")
//				}
//			}.store(in: &cancellables)
//
//		requestUserToken()
//			.receive(on: DispatchQueue.main)
//			.sink(receiveCompletion: {[weak self] completion in
//				guard let self = self else { return }
//				switch completion {
//					case .finished: break
//					case .failure(let error): self.alertViewModel?.present(title: error.localizedDescription)
//				}
//			}, receiveValue: {[weak self] userToken in
//				guard let self = self else { return }
//				self.userToken = userToken
//			})
//			.store(in: &cancellables)
//
//		countryCodeFuture
//			.receive(on: RunLoop.main)
//			.sink(receiveCompletion: {[weak self] completion in
//				guard let self = self else { return }
//				switch completion {
//					case .finished: break
//					case .failure(let error): self.alertViewModel?.present(title: error.localizedDescription)
//				}
//			}, receiveValue: {[weak self] countryCode in
//				guard let self = self else { return }
//				self.countryCode = countryCode
//			})
//			.store(in: &cancellables)
//	}
//
//	static func requestAuthorization() -> Future<SKCloudServiceAuthorizationStatus, Never> {
//		return Future { promise in
//			SKCloudServiceController.requestAuthorization { status in
//				promise(.success(status))
//			}
//		}
//	}
//
//	static func requestUserToken() -> Future<String, Error> {
//		Future { promise in
//			SKCloudServiceController().requestUserToken(forDeveloperToken: developerToken) { userToken, error in
//				if let error = error {
//					promise(.failure(error))
//				} else if let userToken = userToken {
//					promise(.success(userToken))
//				}
//			}
//		}
//	}
//
//	static func requestStorefrontCountryCode() -> Future<String, Error> {
//		Future { promise in
//			SKCloudServiceController().requestStorefrontCountryCode { countryCode, error in
//				if let error = error {
//					promise(.failure(error))
//				}
//
//				if let countryCode = countryCode {
//					promise(.success(countryCode))
//				}
//			}
//		}
//	}
//}
