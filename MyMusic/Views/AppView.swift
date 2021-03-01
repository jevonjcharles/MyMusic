//
//  AppView.swift
//  MyMusic
//
//  Created by Jevon Charles on 2/27/21.
//

import SwiftUI

struct AppView: View {
	@StateObject private var musicKitViewModel: MusicKitViewModel
	@StateObject private var alertViewModel: AlertViewModel

	init() {
		let alertViewModel = AlertViewModel()
		let musicKitViewModel = StateObject(wrappedValue: MusicKitViewModel(alertViewModel: alertViewModel))
		_musicKitViewModel = musicKitViewModel
		_alertViewModel = StateObject(wrappedValue: alertViewModel)
	}

	var body: some View {
		TranslucentTabView {
			LibraryView()
		}
		.alert(isPresented: $alertViewModel.isPresented) {
			alertViewModel.alert
		}
	}
}

struct AppView_Previews: PreviewProvider {
	static var previews: some View {
		AppView()
	}
}
