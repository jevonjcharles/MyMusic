//
//  MediaItem.swift
//  MyMusic
//
//  Created by Jevon Charles on 3/11/21.
//

import Foundation
import MediaPlayer

protocol MediaItem: Media {
	var title: String { get }
	var trackNumber: Int { get }
	var isExplicit: Bool { get }
	var isCloudItem: Bool { get }
	var playbackDuration: Int { get }
	var storeID: String { get }
	var dateAdded: Date { get }
}
