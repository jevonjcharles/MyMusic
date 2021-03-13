//
//  MPMediaItemCollection+.swift
//  MyMusic
//
//  Created by Jevon Charles on 3/3/21.
//

import MediaPlayer

extension MPMediaItemCollection {
	var title: String {
		self.value(forKey: MPMediaPlaylistPropertyName) as? String ?? ""
	}
}
