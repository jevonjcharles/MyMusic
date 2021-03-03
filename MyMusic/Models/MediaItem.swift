//
//  MediaItem.swift
//  MyMusic
//
//  Created by Jevon Charles on 3/2/21.
//

import Foundation
import MediaPlayer

struct MediaItem {
	var artist: String
	var title: String
	var id: MPMediaEntityPersistentID

	init(item: MPMediaItem) {
		self.artist = item.artist ?? ""
		self.title = item.title ?? ""
		self.id = item.persistentID
	}
}
