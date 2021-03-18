//
//  MediaCard.swift
//  MyMusic
//
//  Created by Jevon Charles on 3/11/21.
//

import SwiftUI

struct AlbumCard: View {
	var album: Album
	@State private var isActive = false

    var body: some View {
			VStack(alignment: .leading) {
				ArtworkView(artwork: album.artwork)

				Text(album.albumTitle)
					.foregroundColor(.primary)
					.lineLimit(1)
					.font(.subheadline)
				Text(album.artistName)
					.foregroundColor(.secondary)
					.lineLimit(1)
					.font(.subheadline)
			}
			.onTapGesture {
				self.isActive = true
			}
			.background(
				NavigationLink(destination: AlbumDetailView(album: album), isActive: $isActive) {
					EmptyView()
				}
			)
    }
}
