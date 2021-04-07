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
	@Published var playbackState: MPMusicPlaybackState = .stopped
	@Published var playButtonImageName: String = "play.fill"
	@Published var currentTime: Int = 0
	private var musicPlayer = MPMusicPlayerApplicationController.applicationQueuePlayer
	private var cancellables = Set<AnyCancellable>()

	public func queue(_ songs: [String]) {
		musicPlayer.setQueue(with: songs)
	}

	init() {
		let center = NotificationCenter.default
		center
			.publisher(for: Notification.Name.MPMusicPlayerControllerNowPlayingItemDidChange)
			.compactMap { $0.object as? MPMusicPlayerController }
			.map(\.nowPlayingItem)
			.sink {[weak self] item in
				guard let self = self else { return }
				if let item = item {
					self.song = Song(mediaItem: item, albumTitle: item.albumTitle ?? "Unknown")
				} else {
					self.song = nil
				}
			}.store(in: &cancellables)

		center
			.publisher(for: Notification.Name.MPMusicPlayerControllerPlaybackStateDidChange)
			.compactMap { $0.object as? MPMusicPlayerController }
			.map(\.playbackState)
			.sink {[weak self] state in
				guard let self = self else { return }
				print(state.rawValue)
				self.playbackState = state
				if state == .playing {
					self.playButtonImageName = "pause.fill"
				} else {
					self.playButtonImageName = "play.fill"
				}
			}.store(in: &cancellables)
	}

	public func forward() {
		musicPlayer.currentPlaybackTime = 50
	}

	public func play() {
		musicPlayer.prepareToPlay()
		musicPlayer.play()
	}

	public func playPause() {
		if playbackState == .playing {
			musicPlayer.pause()
		} else {
			play()
		}
	}

	public func skipToNextItem() {
		print("NEXT")
		musicPlayer.skipToNextItem()
	}
}
