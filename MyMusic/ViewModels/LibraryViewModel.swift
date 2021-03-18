//
//  LibraryViewModel.swift
//  MyMusic
//
//  Created by Jevon Charles on 2/26/21.
//

import Combine
import SwiftUI
import MediaPlayer

class LibraryViewModel: ObservableObject {
	@Published var recentlyAdded: [Album] = []
	@Published var isExpended = false
	@Published var buttonTitle = "Edit"
	private let cutoffDate = Calendar.current.date(byAdding: .year, value: -2, to: Date())!
	private var cancellables = Set<AnyCancellable>()
	
	init() {
		recentlyAdded = fetchRecentlyAdded()

		$isExpended
			.receive(on: RunLoop.main)
			.sink {[weak self] bool in
				guard let self = self else { return }
				switch bool {
					case true: self.buttonTitle = "Done"
					case false: self.buttonTitle = "Edit"
				}
			}
			.store(in: &cancellables)
	}
}
// MARK: - Public Functions
extension LibraryViewModel {
	public func viewable(_ menuItems: FetchedResults<MenuItem>) -> [MenuItem] {
		if isExpended {
			return Array(menuItems)
		} else {
			return menuItems.filter { $0.isViewable == true }
		}
	}

	public func move(_ items: FetchedResults<MenuItem>, source: IndexSet, to destination: Int, andSave save: ()->Void) {
		var revisedItems: [MenuItem] = items.map{ $0 }
		revisedItems.move(fromOffsets: source, toOffset: destination)
		for reverseIndex in stride(from: revisedItems.count - 1, through: 0, by: -1 ) {
			revisedItems[reverseIndex].position = Int16(reverseIndex)
		}
		save()
	}
}
// MARK: - Private Functions
extension LibraryViewModel {
	private func fetchRecentlyAdded() -> [Album] {
		guard var songs = MPMediaQuery.songs().items else { return [] }
		songs.removeAll(where: { $0.dateAdded < cutoffDate })
		let clippedSongs = Array(songs.prefix(4000))

		var albums = [Album]()
		clippedSongs.forEach { song in
			if albums.allSatisfy({ $0.id != song.albumPersistentID }) {
				let persistentID = song.albumPersistentID
				let predicate = MPMediaPropertyPredicate(value: persistentID,
																								 forProperty: MPMediaItemPropertyAlbumPersistentID,
																								 comparisonType: .equalTo)
				let set = Set([predicate])
				let queryResult = MPMediaQuery(filterPredicates: set)
				queryResult.groupingType = .album
				guard let album = queryResult.collections?.first else { return }
				albums.append(Album(mediaItemCollection: album))
			}
		}

		let clippedAlbums = Set(albums)
		let orderedAlbums = Array(clippedAlbums).sorted(by: { $0.dateAdded > $1.dateAdded }).prefix(60)
		return Array(orderedAlbums)
	}
}
