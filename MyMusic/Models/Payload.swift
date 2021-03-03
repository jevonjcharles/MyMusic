//
//  Playload.swift
//  MyMusic
//
//  Created by Jevon Charles on 3/1/21.
//

import Foundation

struct Payload<T: Decodable>: Decodable {
	var items: [T]

	enum CodingKeys: String, CodingKey {
		case items = "data"
	}
}
