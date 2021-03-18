//
//  AlbumHeaderView.swift
//  MyMusic
//
//  Created by Jevon Charles on 3/18/21.
//

import SwiftUI

struct AlbumHeaderView: View {
	var album: Album

	var body: some View {
		VStack(spacing: 15) {
			HStack {
				Spacer()
				ArtworkView(artwork: album.artwork, size: .medium)
				Spacer()
			}

			VStack {
				Text(album.albumTitle)
					.foregroundColor(.primary)
					.fontWeight(.bold)
					.font(.title3)
					.multilineTextAlignment(.center)

				Text(album.artistName)
					.foregroundColor(.red)
					.font(.title3)

				Text("\(album.genre.uppercased()) • \(album.releaseDate)")
					.foregroundColor(.secondary)
					.font(.caption2)
					.fontWeight(.bold)
			}
			.frame(width: 320)
		}
	}
}
