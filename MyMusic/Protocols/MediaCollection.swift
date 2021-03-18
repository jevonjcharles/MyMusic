//
//  MediaCollection.swift
//  MyMusic
//
//  Created by Jevon Charles on 3/11/21.
//

import Foundation
import MediaPlayer

protocol MediaCollection: Media {
	var songs: [Song] { get set }
	var releaseDate: String { get }
}
