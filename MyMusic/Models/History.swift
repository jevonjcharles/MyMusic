//
//  History.swift
//  MyMusic
//
//  Created by Jevon Charles on 3/1/21.
//

import Foundation

struct History: Decodable {
	var attributes: Attributes?
	var href: String?
	var id: String?
	var type: String?
}

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

struct Artwork: Decodable {
	var bgColor: String?
	var height: Int?
	var textColor1: String?
	var textColor2: String?
	var textColor3: String?
	var textColor4: String?
	var url: String
	var width: Int?
}

struct PlayParams: Decodable {
	var id: String
	var isLibrary: Bool
	var kind: String
}

struct Payload<T: Decodable>: Decodable {
	var items: [T]

	enum CodingKeys: String, CodingKey {
		case items = "data"
	}
}
