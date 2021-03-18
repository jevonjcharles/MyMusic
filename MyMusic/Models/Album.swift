//
//  MediaItem.swift
//  MyMusic
//
//  Created by Jevon Charles on 3/2/21.
//

import Foundation
import MediaPlayer

struct Album: MediaCollection, Identifiable {
	let id: MPMediaEntityPersistentID
	let albumTitle: String
	let artistName: String
	let genre: String
	let releaseDate: String
	var playbackDuration: Int = 0
	var artwork: UIImage?
	var songs: [Song] = []

	var dateAdded: Date {
		songs.max(by: { $0.dateAdded < $1.dateAdded })?.dateAdded ?? Date()
	}

	init(mediaItemCollection: MPMediaItemCollection) {
		self.id = mediaItemCollection.representativeItem!.albumPersistentID
		self.albumTitle = mediaItemCollection.items.first?.albumTitle ?? "Unknown"
		self.artistName = mediaItemCollection.representativeItem?.albumArtist ?? "Unknown"
		self.genre = mediaItemCollection.representativeItem?.genre ?? "Unknown"
		if let date = mediaItemCollection.representativeItem?.releaseDate {
			let formatter = DateFormatter()
			formatter.dateFormat = "yyyy"
			releaseDate = formatter.string(from: date)
		} else {
			releaseDate = "Unknown"
		}

		self.songs = mediaItemCollection.items.map { Song(mediaItem: $0, albumTitle: self.albumTitle) }
		playbackDuration = songs.map(\.playbackDuration).reduce(0, +) / 60
		if let item = mediaItemCollection.representativeItem,
			 let artwork = item.artwork,
			 let image = artwork.image(at: artwork.bounds.size) {
			self.artwork = image
		}
	}
}

extension Album: Hashable {
	static func == (lhs: Album, rhs: Album) -> Bool {
		lhs.id == rhs.id
	}

	func hash(into hasher: inout Hasher) {
		hasher.combine(id)
	}
}
