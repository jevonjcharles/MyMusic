//
//  SongList.swift
//  MyMusic
//
//  Created by Jevon Charles on 3/18/21.
//

import SwiftUI

struct SongList: View {
	@EnvironmentObject var musicController: MusicController
	@ObservedObject var songListViewModel = SongListViewModel()
	var songs: [Song]

	var body: some View {
		ForEach(songs) { song in
			VStack(alignment: .leading) {
				HStack {
					Text("\(song.trackNumber)")
						.foregroundColor(.secondary)
					Text(song.title)
						.foregroundColor(.primary)
						.padding(.leading, 10)
					if song.isExplicit {
						ExplicitView()
					}
					Spacer()
					if song.isCloudItem {
						CloudButton(download: download)
					}
				}
				.padding(.vertical, 6)
				.padding(.horizontal, 20)
				Divider()
					.offset(x: 40, y: 0)
			}
			.contentShape(Rectangle())
			.onTapGesture {
				songListViewModel.queue(songs, from: song.trackNumber, with: musicController)
			}
		}
	}

	private func download() {

	}
}
