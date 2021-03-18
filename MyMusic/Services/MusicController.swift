//
//  Player.swift
//  MyMusic
//
//  Created by Jevon Charles on 3/16/21.
//

import Foundation
import Combine
import MediaPlayer

final class MusicController: ObservableObject {
	private let musicPlayer = MPMusicPlayerApplicationController.applicationQueuePlayer

	public func queue(_ songs: [String]) {
		musicPlayer.setQueue(with: songs)
	}

	public func play() {
		musicPlayer.prepareToPlay()
		musicPlayer.play()
	}
}
