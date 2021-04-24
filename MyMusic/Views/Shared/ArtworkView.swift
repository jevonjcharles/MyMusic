//
//  ArtworkView.swift
//  MyMusic
//
//  Created by Jevon Charles on 3/11/21.
//

import SwiftUI

struct ArtworkView: View {
	var artwork: UIImage?
	var size: ArtworkSize
	private var frame: CGFloat {
		switch size {
			case .extraSmall: return 40
			case .small: return 50
			case .regular: return 180
			case .medium: return 280
			case .large: return 450
		}
	}

	init(song: Binding<Song?>? = nil, artwork: UIImage? = nil, size: ArtworkSize = .regular) {
		if let songBinding = song, let unwrappedSong = songBinding.wrappedValue {
			self.artwork = unwrappedSong.artwork
		} else {
			self.artwork = artwork
		}
		self.size = size
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
				.overlay(Image(systemName: "music.note"))
		}
	}
}
