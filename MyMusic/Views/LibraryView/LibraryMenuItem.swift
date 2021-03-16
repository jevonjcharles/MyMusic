//
//  LibraryMenuItem.swift
//  MyMusic
//
//  Created by Jevon Charles on 3/3/21.
//

import SwiftUI

struct MenuRowView: View {
	@ObservedObject var menuItem: MenuItem
	@Binding var isExpended: Bool

	var body: some View {
		HStack {
			if menuItem.isViewable && isExpended {
				Image(systemName: "checkmark.circle.fill")
					.transition(.move(edge: isExpended ? .leading : .trailing))
					.font(.title2)
					.frame(width: 30, height: 41, alignment: .center)
					.foregroundColor(.red)
			} else if isExpended {
				Spacer()
					.frame(width: 30, height: 41, alignment: .center)
			}
			Image(systemName: menuItem.unwrappedImageName)
				.font(.title2)
				.frame(width: 30, height: 41, alignment: .center)
				.foregroundColor(.red)
			Text(menuItem.unwrappedTitle)
				.font(.title2)
				.foregroundColor(.primary)
			Spacer()
		}
	}
}
