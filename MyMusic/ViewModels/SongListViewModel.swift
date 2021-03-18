//
//  SongListViewModel.swift
//  MyMusic
//
//  Created by Jevon Charles on 3/18/21.
//

import Combine

final class SongListViewModel: ObservableObject {

	public func queue(_ songs: [Song], from track: Int, with musicController: MusicController) {
		let songsToQueue = songs.suffix(from: track - 1).map(\.storeID)
		musicController.queue(songsToQueue)
		musicController.play()
	}
}
