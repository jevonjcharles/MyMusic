//
//  AppView.swift
//  MyMusic
//
//  Created by Jevon Charles on 2/27/21.
//

import SwiftUI

struct AppView: View {
	@StateObject private var userTokenViewModel: UserTokenViewModel
	@StateObject private var alertViewModel: AlertViewModel

	init() {
		let alertViewModel = AlertViewModel()
		let userTokenViewModel = StateObject(wrappedValue: UserTokenViewModel(alertViewModel: alertViewModel))
		_userTokenViewModel = userTokenViewModel
		_alertViewModel = StateObject(wrappedValue: alertViewModel)
	}

	var body: some View {
		TranslucentTabView {
			LibraryView()
		}
		.alert(isPresented: $alertViewModel.isPresented, content: {
			alertViewModel.alert
		})
	}
}

struct AppView_Previews: PreviewProvider {
	static var previews: some View {
		AppView()
	}
}
