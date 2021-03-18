//
//  Media.swift
//  MyMusic
//
//  Created by Jevon Charles on 3/18/21.
//

import Foundation
import MediaPlayer

protocol Media: Identifiable {
	var id: MPMediaEntityPersistentID { get }
	var albumTitle: String { get }
	var artistName: String { get }
	var genre: String { get }
	var artwork: UIImage? { get }
}
