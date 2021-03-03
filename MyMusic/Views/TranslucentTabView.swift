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
					VisualEffectView(effect: UIBlurEffect(style: colorScheme == .light ? .systemMaterialLight : .prominent))
						.frame(height: 80)
						.overlay(
							Bar()
								.padding(.horizontal, 25)
								.padding(.vertical, 8)
								.foregroundColor(.red)
								.frame(height: 80)
						)
				}
			}
			.ignoresSafeArea()
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
	var imageNames = [
		("play.circle.fill", "Listen Now"),
		("square.grid.2x2.fill", "Browse"),
		("dot.radiowaves.left.and.right", "Radio"),
		("rectangle.stack.fill", "Library"),
		("magnifyingglass", "Search")
	]

	var body: some View {
		VStack {
			HStack(alignment: .lastTextBaseline) {
				ForEach(imageNames, id: \.0) { imageName in
					TranslucentItem(imageName: imageName.0, text: imageName.1)
					if imageName.0 != imageNames[4].0 {
						Spacer()
					}
				}
			}
			Spacer()
		}
	}
}

struct VisualEffectView: UIViewRepresentable {
	var effect: UIVisualEffect?
	func makeUIView(context: UIViewRepresentableContext<Self>) -> UIVisualEffectView { UIVisualEffectView() }
	func updateUIView(_ uiView: UIVisualEffectView, context: UIViewRepresentableContext<Self>) { uiView.effect = effect }
}
