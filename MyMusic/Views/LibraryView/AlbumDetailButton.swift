//
//  AlbumDetailButton.swift
//  MyMusic
//
//  Created by Jevon Charles on 3/18/21.
//

import SwiftUI

struct AlbumDetailButton: View {
	var action: () -> Void
	var imageName: String
	var title: String

    var body: some View {
			Button(action: action, label: {
				HStack {
					Image(systemName: imageName)
					Text(title)
						.fontWeight(.bold)
				}
				.foregroundColor(.red)
			})
			.frame(height: 15)
			.frame(maxWidth: .infinity)
			.padding()
			.background(Color.gray.opacity(0.2))
			.cornerRadius(8)
    }
}
