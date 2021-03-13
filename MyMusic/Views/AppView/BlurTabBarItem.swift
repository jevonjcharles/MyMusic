//
//  BarItem.swift
//  MyMusic
//
//  Created by Jevon Charles on 3/3/21.
//

import SwiftUI

struct BlurTabBarItem: View {
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
