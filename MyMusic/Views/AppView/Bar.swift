//
//  Bar.swift
//  MyMusic
//
//  Created by Jevon Charles on 3/3/21.
//

import SwiftUI

struct BlurBarView: View {
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
					BlurTabBarItem(imageName: imageName.0, text: imageName.1)
					if imageName.0 != imageNames[4].0 {
						Spacer()
					}
				}
			}
			Spacer()
		}
	}
}
