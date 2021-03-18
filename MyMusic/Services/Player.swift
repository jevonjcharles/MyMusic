//
//  Player.swift
//  MyMusic
//
//  Created by Jevon Charles on 3/16/21.
//

import Foundation
import Combine
import MediaPlayer

final class Player: ObservableObject {
	private let musicPlayer = MPMusicPlayerApplicationController.applicationQueuePlayer

	public func queue(_ songs: [String], and startPlaying: Bool) {
		musicPlayer.setQueue(with: songs)
		musicPlayer.prepareToPlay()
		if startPlaying {
			play()
		}
	}

	public func play() {
		musicPlayer.play()
	}
}
