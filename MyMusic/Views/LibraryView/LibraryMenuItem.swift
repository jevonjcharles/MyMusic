//
//  LibraryMenuItem.swift
//  MyMusic
//
//  Created by Jevon Charles on 3/3/21.
//

import SwiftUI

struct MenuRowView: View {
	@ObservedObject var menuItem: MenuItem

	var body: some View {
		HStack {
			Image(systemName: menuItem.unwrappedImageName)
				.font(.title2)
				.frame(width: 30, height: 41, alignment: .center)
				.foregroundColor(.red)
			Text(menuItem.unwrappedTitle)
				.font(.title2)
				.foregroundColor(.primary)
		}
	}
}
