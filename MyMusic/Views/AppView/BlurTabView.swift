//
//  TranslucentTabView.swift
//  MyMusic
//
//  Created by Jevon Charles on 2/27/21.
//

import SwiftUI

struct BlurTabView<Content: View>: View {
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
					BlurView(effect: UIBlurEffect(style: colorScheme == .light ? .systemMaterialLight : .prominent))
						.frame(height: 80)
						.overlay(
							BlurBarView()
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
