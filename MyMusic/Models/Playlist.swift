//
//  Playlist.swift
//  MyMusic
//
//  Created by Jevon Charles on 3/11/21.
//

import Foundation
import MediaPlayer

struct Playlist: MediaCollection {
	let id: MPMediaEntityPersistentID
	let albumTitle: String
	let genre: String
	let artistName: String
	let releaseDate: String
	var playbackDuration: Int = 0
	var artwork: UIImage?
	var songs: [Song] = []
	let storeID: String = ""

	var dateAdded: Date {
		songs.max(by: { $0.dateAdded < $1.dateAdded })?.dateAdded ?? Date()
	}

	init(mediaPlaylist: MPMediaPlaylist) {
		self.id = mediaPlaylist.persistentID
		self.albumTitle = mediaPlaylist.name ?? "Unknown"
		self.genre = mediaPlaylist.representativeItem?.genre ?? "Unknown"
		self.artistName = mediaPlaylist.name ?? "Apple Music"

		if let date = mediaPlaylist.representativeItem?.releaseDate {
			let formatter = DateFormatter()
			formatter.dateFormat = "yyyy"
			releaseDate = formatter.string(from: date)
		} else {
			releaseDate = "Unknown"
		}

		self.songs = mediaPlaylist.items.map { Song(mediaItem: $0, albumTitle: self.albumTitle) }

		if let item = mediaPlaylist.representativeItem,
			 let artwork = item.artwork,
			 let image = artwork.image(at: artwork.bounds.size) {
			self.artwork = image
		}
	}
}
