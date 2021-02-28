//
//  AlertViewModel.swift
//  MyMusic
//
//  Created by Jevon Charles on 2/27/21.
//

import SwiftUI
import Combine

class AlertViewModel: ObservableObject {
	@Published var isPresented: Bool = false

	private var titleText: Text = Text("")
	private var messageText: Text?

	var alert: Alert {
		Alert(title: titleText, message: messageText)
	}

	func present(title: String, message: String? = nil) {
		titleText = Text(title)
		if let message = message {
			messageText = Text(message)
		}
		isPresented = true
	}
}
