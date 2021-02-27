//
//  ContentView.swift
//  MyMusic
//
//  Created by Jevon Charles on 2/26/21.
//

import SwiftUI
import StoreKit

struct LibraryView: View {
	var body: some View {
		Text("Hello, world!")
				.padding()
			.onAppear {
				SKCloudServiceController.requestAuthorization { (status: SKCloudServiceAuthorizationStatus) in
					switch status {
						case .notDetermined:
							print("NOT DETERMINED")
						case .denied:
							print("DENIED")
						case .restricted:
							print("RESTRICTED")
						case .authorized:
							print("AUTHORIZED")
							next()
						@unknown default:
							print("UNKNOWN")
					}
				}
			}
	}

	private func next() {
		let cont = SKCloudServiceController()
		cont.requestUserToken(forDeveloperToken: dev) { (userToken: String? , error: Error?) in
			if let error = error {
				print("ERROR: \(error.localizedDescription)")
			} else if let userToken = userToken {
				print(userToken)
			} else {
				print("###\(#function)UNKNOWN")
			}
		}
	}
}

struct ContentView_Previews: PreviewProvider {
	static var previews: some View {
		LibraryView()
	}
}
