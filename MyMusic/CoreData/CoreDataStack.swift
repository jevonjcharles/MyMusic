//
//  CoreDataStack.swift
//  MyMusic
//
//  Created by Jevon Charles on 3/13/21.
//

import Foundation
import CoreData

final class CoreDataStack: ObservableObject {
	let container: NSPersistentCloudKitContainer
	let scratchpadContext: NSManagedObjectContext
	let viewContext: NSManagedObjectContext

	init() {
		container = NSPersistentCloudKitContainer(name: "MyMusic")
		let defaultURL = NSPersistentCloudKitContainer.defaultDirectoryURL()

		let privateStoreURL = defaultURL.appendingPathComponent("com.JevonCharles.MyMusic.Private.sqlite")
		let privateStoreDescription = NSPersistentStoreDescription(url: privateStoreURL)
		privateStoreDescription.configuration = "Private"
		let privateOptions = NSPersistentCloudKitContainerOptions(containerIdentifier: "iCloud.com.JevonCharles.MyMusic")
		privateOptions.databaseScope = .private
		privateStoreDescription.cloudKitContainerOptions = privateOptions
		privateStoreDescription.setOption(true as NSNumber, forKey: NSPersistentHistoryTrackingKey)
		privateStoreDescription.setOption(true as NSNumber, forKey: NSPersistentStoreRemoteChangeNotificationPostOptionKey)

		container.loadPersistentStores(completionHandler: { store, error in
			if let error = error {
				fatalError("Fatal error loading store: \(error.localizedDescription)")
			}
		})

		let scratchpadContext = NSManagedObjectContext(concurrencyType: .mainQueueConcurrencyType)
		scratchpadContext.parent = container.viewContext
		self.scratchpadContext = scratchpadContext
		container.viewContext.mergePolicy = NSMergeByPropertyStoreTrumpMergePolicy
		container.viewContext.automaticallyMergesChangesFromParent = true
		self.viewContext = container.viewContext

		// Good for this portfolio app but in a real production app would use something else.
		let hasAlreadyLaunched = UserDefaults.standard.bool(forKey: "hasAlreadyLaunched")
		if !hasAlreadyLaunched {
			print("First Launched")
			buildMenuItemsList()
			UserDefaults.standard.set(true, forKey: "hasAlreadyLaunched")
		} else {
			print("Has Launched before")
		}
	}

	private func buildMenuItemsList() {
		MenuType.allCases.forEach { type in
			let item = MenuItem(context: scratchpadContext)
			item.id = UUID()
			item.imageName = type.imageName
			item.title = type.description
			item.type = type.rawValue
			item.position = type.rawValue
			switch type {
				case .playlists: item.isViewable = true
				case .artist: item.isViewable = true
				case .songs: item.isViewable = true
				case .albums: item.isViewable = true
				case .tvMovies: item.isViewable = false
				case .musicVideos: item.isViewable = false
				case .genres: item.isViewable = false
				case .compilations: item.isViewable = false
				case .composers: item.isViewable = false
				case .downloaded: item.isViewable = true
				case .homeSharing: item.isViewable = true
			}
		}
		saveScratchContext()
	}

	public func saveScratchContext() {
		if scratchpadContext.hasChanges {
			scratchpadContext.perform {
				do {
					try self.scratchpadContext.save()
					print("SCRATCH")
				} catch let error {
					fatalError("Error: SAVING SCRATCH \(error.localizedDescription) \(error)")
				}
				self.saveViewContext()
			}
		}
	}

	public func saveViewContext() {
		if viewContext.hasChanges {
			do {
				try self.viewContext.save()
				print("MAIN")
			} catch let error {
				print("Error: SAVING MAIN \(error), \(error.localizedDescription)")
			}
		}
	}

	public func deleteFromViewContext(_ object: NSManagedObject) {
		viewContext.delete(object)
		print("DELETE FROM VIEWCONTEXT")
		saveViewContext()
	}

	public func deleteFromScratchContext(_ object: NSManagedObject) {
		scratchpadContext.delete(object)
		print("DELETE FROM SCRATCHCONTEXT")
	}
}
