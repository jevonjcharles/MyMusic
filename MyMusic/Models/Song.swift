//
//  Song.swift
//  MyMusic
//
//  Created by Jevon Charles on 3/11/21.
//

import Foundation
import MediaPlayer

struct Song: MediaItem, Identifiable {
	let id: MPMediaEntityPersistentID
	let artistName: String
	let albumTitle: String
	let genre: String
	let title: String
	let trackNumber: Int
	let isExplicit: Bool
	let isCloudItem: Bool
	let playbackDuration: Int
	var artwork: UIImage?
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
