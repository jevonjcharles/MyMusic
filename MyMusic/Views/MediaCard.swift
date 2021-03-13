//
//  MediaCard.swift
//  MyMusic
//
//  Created by Jevon Charles on 3/11/21.
//

import SwiftUI

struct MediaCard<T: MediaCollection>: View {
	var item: T
	@State private var isActive = false

    var body: some View {
			VStack(alignment: .leading) {
				ArtworkView(artwork: item.artwork)

				Text(item.albumTitle)
					.foregroundColor(.primary)
					.lineLimit(1)
					.font(.body)
				Text(item.artistName)
					.foregroundColor(.secondary)
					.lineLimit(1)
					.font(.body)
			}
			.onTapGesture {
				self.isActive = true
			}
			.background(
				NavigationLink(destination: MediaDetailView(item: item), isActive: $isActive) {
					EmptyView()
				}
			)
    }
}
