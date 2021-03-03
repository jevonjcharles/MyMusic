//
//  PlayParams.swift
//  MyMusic
//
//  Created by Jevon Charles on 3/1/21.
//

import Foundation

struct PlayParams: Decodable {
	var id: String
	var isLibrary: Bool
	var kind: String
}
