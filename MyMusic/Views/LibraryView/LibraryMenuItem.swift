//
//  LibraryMenuItem.swift
//  MyMusic
//
//  Created by Jevon Charles on 3/3/21.
//

import SwiftUI

struct LibraryMenuItem: View {
	var imageName: String
	var text: String

	var body: some View {
		HStack {
			Image(systemName: imageName)
				.font(.title2)
				.frame(width: 30, height: 41, alignment: .center)
				.foregroundColor(.red)
			Text(text)
				.font(.title2)
				.foregroundColor(.primary)
		}
	}
}
