//
//  ArtworkView.swift
//  MyMusic
//
//  Created by Jevon Charles on 3/11/21.
//

import SwiftUI

struct ArtworkView: View {
	var artwork: UIImage?
	var size: ArtworkSize = .regular
	private var frame: CGFloat {
		switch size {
			case .regular: return 180
			case .medium: return 280
			case .large: return 450
		}
	}

	var body: some View {
		if let artwork = artwork {
			Image(uiImage: artwork)
				.resizable()
				.frame(width: frame, height: frame, alignment: .center)
				.cornerRadius(8)
		} else {
			Color.gray.frame(width: frame, height: frame, alignment: .center)
				.cornerRadius(8)
		}
	}
}
