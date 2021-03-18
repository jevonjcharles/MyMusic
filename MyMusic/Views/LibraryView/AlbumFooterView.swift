//
//  AlbumFooterView.swift
//  MyMusic
//
//  Created by Jevon Charles on 3/18/21.
//

import SwiftUI

struct AlbumFooterView: View {
	var album: Album

	var body: some View {
		HStack {
			VStack(alignment: .leading) {
				Text("\(album.songs.count) \(album.songs.count > 1 ? "songs" : "song") \(album.playbackDuration) \(album.playbackDuration > 1 ? "minutes" : "minute")")
				Text("℗ \(album.releaseDate)")
					.font(.footnote)
			}
			.padding()
			Spacer()
		}
		.foregroundColor(.secondary)
	}
}
