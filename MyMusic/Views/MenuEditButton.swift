//
//  MenuEditButton.swift
//  MyMusic
//
//  Created by Jevon Charles on 3/14/21.
//

import SwiftUI

struct MenuEditButton: View {
	@ObservedObject var libraryViewModel: LibraryViewModel

	var body: some View {
		Button(action: {
			withAnimation {
				libraryViewModel.isExpended.toggle()
			}
		}, label: {
			Text(libraryViewModel.buttonTitle)
				.foregroundColor(.red)
		})
	}
}
