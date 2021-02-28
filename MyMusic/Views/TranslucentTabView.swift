//
//  TranslucentTabView.swift
//  MyMusic
//
//  Created by Jevon Charles on 2/27/21.
//

import SwiftUI

struct TranslucentTabView<Content: View>: View {
	@Environment(\.colorScheme) var colorScheme

	let content: Content

	init(@ViewBuilder content: () -> Content) {
		self.content = content()
	}
    var body: some View {
			ZStack {
				content

				VStack {
					Spacer()
					(colorScheme == .dark ? Color.black : Color.white)
						.frame(height: 80)
						.blur(radius: 0.5)
						.opacity(colorScheme == .dark ? 0.9 : 0.96)
						.overlay(
							Bar()
							.padding(.horizontal, 25)
							.padding(.vertical, 8)
							.foregroundColor(.red)
							.frame(height: 80)
						)
				}			.ignoresSafeArea()

			}
    }
}

struct TranslucentItem: View {
	var imageName: String
	var text: String

	var body: some View {
		VStack {
			Image(systemName: imageName)
				.font(.title3)
			Text(text)
				.font(.caption2)
		}
		.foregroundColor(.red)
	}
}

struct Bar: View {

	var body: some View {
		VStack {
			HStack(alignment: .top) {
				TranslucentItem(imageName: "play.circle.fill", text: "Listen Now")
				Spacer()
				TranslucentItem(imageName: "square.grid.2x2.fill", text: "Browse")
				Spacer()
				TranslucentItem(imageName: "dot.radiowaves.left.and.right", text: "Radio")
				Spacer()
				TranslucentItem(imageName: "rectangle.stack.fill", text: "Library")
				Spacer()
				TranslucentItem(imageName: "magnifyingglass", text: "Search")
			}
			Spacer()
		}
	}
}
