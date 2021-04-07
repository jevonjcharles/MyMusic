//
//  SongListViewModel.swift
//  MyMusic
//
//  Created by Jevon Charles on 3/18/21.
//

import Combine

final class AlbumDetailViewModel: ObservableObject {

	public func queue(_ songs: [Song], from track: Int, with musicController: MusicController) {
		if songs.count == 1 {
			musicController.queue(songs.map(\.storeID))
			musicController.play()
		} else {
			let songsToQueue = songs.suffix(from: track - 1).map(\.storeID)
			musicController.queue(songsToQueue)
			musicController.play()
		}
	}

	public func download() {
		
	}
}
