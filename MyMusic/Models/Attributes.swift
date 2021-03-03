//
//  Attributes.swift
//  MyMusic
//
//  Created by Jevon Charles on 3/1/21.
//

import Foundation

struct Attributes: Decodable {
	var artistName: String?
	var copyright: String?
	var genreNames: [String]?
	var isComplete: Bool?
	var isMasteredForItunes: Bool?
	var isSingle: Bool?
	var name: String
	var recordLabel: String?
	var releaseDate: String?
	var trackCount: Int?
	var url: URL?
	var artwork: Artwork
	var playParams: PlayParams
}
