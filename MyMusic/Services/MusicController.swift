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
	@Published var song: Song?
	@Published private var musicPlayer = MPMusicPlayerApplicationController.applicationQueuePlayer
	private var cancellables = Set<AnyCancellable>()

	public func queue(_ songs: [String]) {
		musicPlayer.setQueue(with: songs)
	}

	init() {
		NotificationCenter
			.default
			.publisher(for: Notification.Name.MPMusicPlayerControllerNowPlayingItemDidChange)
			.compactMap { $0.object as? MPMusicPlayerController }
			.compactMap { $0.nowPlayingItem }
			.sink {[weak self] item in
				guard let self = self else { return }
				self.song = Song(mediaItem: item, albumTitle: item.albumTitle ?? "Unknown")
			}.store(in: &cancellables)
	}

	public func play() {
		musicPlayer.prepareToPlay()
		musicPlayer.play()
	}
}
