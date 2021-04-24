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
	@Published var recentlyAddedAlbums: [Album] = []
	@Published var selectedMenuItems = Set<MenuItem>()
	@Published var editMode: EditMode = .inactive
	private let cutoffDate = Calendar.current.date(byAdding: .year, value: -2, to: Date())!
	private var cancellables = Set<AnyCancellable>()
	
	init() {
		recentlyAddedAlbums = fetchRecentlyAdded()

		$editMode
			.receive(on: RunLoop.main)
			.sink { mode in
				guard mode == .inactive else { return }
				CoreDataStack.shared.saveViewContext()
			}.store(in: &cancellables)

		$selectedMenuItems
			.receive(on: RunLoop.main)
			.sink { items in
				items.forEach { item in
					if !item.isViewable {
						item.isViewable = true
					}
				}
			}.store(in: &cancellables)
	}
}
// MARK: - Public Functions
extension LibraryViewModel {
	public func move(_ items: FetchedResults<MenuItem>, from source: IndexSet, to destination: Int) {
		var revisedItems: [MenuItem] = items.map{ $0 }
		revisedItems.move(fromOffsets: source, toOffset: destination)
		for reverseIndex in stride(from: revisedItems.count - 1, through: 0, by: -1 ) {
			revisedItems[reverseIndex].position = Int16(reverseIndex)
		}
		CoreDataStack.shared.saveViewContext()
	}

	public func insert(_ menuItems: FetchedResults<MenuItem>) {
		guard editMode == .inactive else { return }
		menuItems
			.filter { $0.isViewable }
			.forEach { selectedMenuItems.insert($0) }
	}

	public func toggleEditMode() {
		if editMode == .inactive {
			editMode = .active
		} else {
			editMode = .inactive
		}
	}

	public func set(_ menuItems: FetchedResults<MenuItem>) {
		guard editMode == .active else { return }
		let allItems = Set(menuItems)
		let difference = selectedMenuItems.symmetricDifference(allItems)
		difference.forEach { $0.isViewable = false }
		CoreDataStack.shared.saveViewContext()
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
