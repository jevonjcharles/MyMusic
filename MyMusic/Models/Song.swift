//
//  Song.swift
//  MyMusic
//
//  Created by Jevon Charles on 3/11/21.
//

import Foundation
import MediaPlayer

struct Song: MediaItem {
	let id: MPMediaEntityPersistentID
	let artistName: String
	let albumTitle: String
	let genre: String
	var artwork: UIImage?

	let title: String
	let trackNumber: Int
	let isExplicit: Bool
	let isCloudItem: Bool
	let playbackDuration: Int
	let storeID: String
	var dateAdded: Date

	init(mediaItem: MPMediaItem, albumTitle: String) {
		id = mediaItem.persistentID
		artistName = mediaItem.albumArtist ?? "Unknown"
		self.albumTitle = mediaItem.albumTitle ?? "Unknown"
		genre = mediaItem.genre ?? "Unknown"
		title = mediaItem.title ?? "Unknown"
		trackNumber = mediaItem.albumTrackNumber
		dateAdded = mediaItem.dateAdded
		isExplicit = mediaItem.isExplicitItem
		isCloudItem = mediaItem.isCloudItem
		storeID = mediaItem.playbackStoreID

		if let duration = mediaItem.value(forKey: MPMediaItemPropertyPlaybackDuration) as? Double {
			playbackDuration = Int(duration)
		} else {
			playbackDuration = 0
		}
		
		if let artwork = mediaItem.artwork,
			 let image = artwork.image(at: artwork.bounds.size) {
			self.artwork = image
		}
	}
}
