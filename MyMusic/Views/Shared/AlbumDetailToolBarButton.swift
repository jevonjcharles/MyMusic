//
//  ToggleButton.swift
//  MyMusic
//
//  Created by Jevon Charles on 3/18/21.
//

import SwiftUI

struct AlbumDetailToolBarButton: View {
	@Binding var flag: Bool
	var imageName: String

	var body: some View {
		Button(action: { flag.toggle() }, label:{
			Image(systemName: imageName)
				.frame(width: 27, height: 27)
				.foregroundColor(.red)
				.padding(2)
				.background(Color.gray.opacity(0.2))
				.clipShape(Circle())
		})
	}
}
