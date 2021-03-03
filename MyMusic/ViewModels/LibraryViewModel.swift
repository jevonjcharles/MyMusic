//
//  LibraryViewModel.swift
//  MyMusic
//
//  Created by Jevon Charles on 2/26/21.
//

import Combine
import Foundation
import MediaPlayer

class LibraryViewModel: ObservableObject {
	@Published var recentlyAdded: [MediaItem] = []

	private let playlistsQuery = MPMediaQuery.playlists()

	init() {
		recentlyAdded = fetchRecentlyAdded()
	}

	private func fetchRecentlyAdded() -> [MediaItem] {
		guard let playlists = playlistsQuery.collections,
					let recentlyAdded = playlists.first(where: { playlist in
						guard let title = playlist.value(forKey: MPMediaPlaylistPropertyName) as? String,
									title == "Recently Added"
						else { return false }
						return true
					})
		else { return [] }
		return recentlyAdded.items
							.map { MediaItem(item: $0) }
							.reversed()
	}
}
