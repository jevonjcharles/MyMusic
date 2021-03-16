//
//  MenuEditButton.swift
//  MyMusic
//
//  Created by Jevon Charles on 3/14/21.
//

import SwiftUI

struct MenuEditButton: View {
	@Binding var isExpended: Bool

	var body: some View {
		Button(action: {
			withAnimation {
				isExpended.toggle()
			}
		}, label: {
			Text("Edit")
				.foregroundColor(.red)
		})
	}
}
