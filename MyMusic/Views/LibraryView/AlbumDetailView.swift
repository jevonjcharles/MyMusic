//
//  MediaDetailView.swift
//  MyMusic
//
//  Created by Jevon Charles on 3/11/21.
//

import SwiftUI

struct AlbumDetailView: View {
	@EnvironmentObject var musicController: MusicController
	var album: Album

	var body: some View {
		ScrollView {
			AlbumHeaderView(album: album)
			HStack(spacing: 20) {
				AlbumDetailButton(action: {
					musicController.queue(album.songs.map(\.storeID))
					musicController.play()
				}, imageName: "play.fill", title: "Play")
				AlbumDetailButton(action: {

				}, imageName: "shuffle", title: "Shuffle")
			}
			.padding()
			Divider()
				.offset(x: 3, y: 0)
				.padding(.top, 10)
			SongList(songs: album.songs)
			AlbumFooterView(album: album)
		}
		.padding(.top, 1)
	}
}
