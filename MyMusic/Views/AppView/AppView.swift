//
//  AppView.swift
//  MyMusic
//
//  Created by Jevon Charles on 2/27/21.
//

import SwiftUI

struct AppView: View {
//	@StateObject private var musicKitService: MusicKitService
//	@StateObject private var alertViewModel: AlertViewModel
//
//	init() {
//		let alertViewModel = AlertViewModel()
//		let musicKitService = StateObject(wrappedValue: MusicKitService(alertViewModel: alertViewModel))
//		_musicKitService = musicKitService
//		_alertViewModel = StateObject(wrappedValue: alertViewModel)
//	}

	var body: some View {
		TabView {
			LibraryView()
				.tabItem {
					Label("Library", systemImage: "rectangle.stack.fill")
				}
//				.environmentObject(musicKitService)
		}
		.accentColor(.red)
//		.alert(isPresented: $alertViewModel.isPresented) {
//			alertViewModel.alert
//		}
	}
}

struct AppView_Previews: PreviewProvider {
	static var previews: some View {
		AppView()
	}
}
