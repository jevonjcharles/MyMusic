//
//  MediaItem.swift
//  MyMusic
//
//  Created by Jevon Charles on 3/11/21.
//

import Foundation
import MediaPlayer

protocol MediaItem {
	var id: MPMediaEntityPersistentID { get }
	var albumTitle: String { get }
	var artistName: String { get }
	var genre: String { get }
	var dateAdded: Date { get }
	var artwork: UIImage? { get }
}
