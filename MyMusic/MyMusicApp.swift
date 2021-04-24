//
//  MyMusicApp.swift
//  MyMusic
//
//  Created by Jevon Charles on 2/26/21.
//

import SwiftUI

@main
struct MyMusicApp: App {
	let coreDataStack = CoreDataStack.shared

	var body: some Scene {
		WindowGroup {
			AppView()
				.environment(\.managedObjectContext, coreDataStack.viewContext)
		}
	}
}
