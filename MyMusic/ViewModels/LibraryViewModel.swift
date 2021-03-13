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
	@Published var recentlyAdded: [Album] = []
	private let cutoffDate = Calendar.current.date(byAdding: .year, value: -2, to: Date())!
	
	init() {
//		var query = MPMediaQuery.songs().collections
//		query?.removeAll(where: { $0.representativeItem?.albumTitle != "FWA" })
//
//		let pre = MPMediaPropertyPredicate(value: query!.first!.representativeItem!.albumPersistentID, forProperty: MPMediaItemPropertyAlbumPersistentID)
//		let set = Set([pre])
//		let q = MPMediaQuery(filterPredicates: set)
//		q.groupingType = .album
//		let result = q.collections!
//		result.forEach { print($0.items.count)}
		recentlyAdded = fetchRecentlyAdded()
	}

	private func fetchRecentlyAdded() -> [Album] {
		guard var songs = MPMediaQuery.songs().items else { return [] }
		songs.removeAll(where: { $0.dateAdded < cutoffDate })
		let clippedSongs = Array(songs.prefix(4000))

//		let first = clippedSongs.first!
//		print(first.albumArtist)
//			print(first.albumArtistPersistentID)
//			print(first.albumPersistentID)
//			print(first.albumTitle)
//			print(first.albumTrackCount)
//			print(first.albumTrackNumber)
//			print(first.artist)
//			print(first.artistPersistentID)
//			print(first.artwork)
//			print(first.assetURL)
//			print(first.beatsPerMinute)
//			print(first.bookmarkTime)
//			print(first.isCloudItem)
//			print(first.comments)
//			print(first.isCompilation)
//			print(first.composer)
//			print(first.composerPersistentID)
//			print(first.dateAdded)
//			print(first.discCount)
//			print(first.discNumber)
//			print(first.isExplicitItem)
//			print(first.genre)
//			print(first.genrePersistentID)
//			print(first.lastPlayedDate)
//			print(first.lyrics)
//			print(first.mediaType)
//			print(first.persistentID)
//			print(first.playCount)
//			print(first.playbackDuration)
//			print(first.playbackStoreID)
//			print(first.podcastPersistentID)
//			print(first.podcastTitle)
//			print(first.hasProtectedAsset)
//			print(first.rating)
//			print(first.releaseDate)
//			print(first.skipCount)
//			print(first.title)
//			print(first.userGrouping)

		var albums = [Album]()
		clippedSongs.forEach { song in
			if albums.allSatisfy({ $0.id != song.albumPersistentID }) {
				let persistentID = song.albumPersistentID
				let predicate = MPMediaPropertyPredicate(value: persistentID,
																								 forProperty: MPMediaItemPropertyAlbumPersistentID,
																								 comparisonType: .equalTo)
				let set = Set([predicate])
				let queryResult = MPMediaQuery(filterPredicates: set)
				queryResult.groupingType = .album
				guard let album = queryResult.collections?.first else { return }
				albums.append(Album(mediaItemCollection: album))
			}
		}

		let clippedAlbums = Set(albums)
		let orderedAlbums = Array(clippedAlbums).sorted(by: { $0.dateAdded > $1.dateAdded }).prefix(60)
		return Array(orderedAlbums)
	}
}

