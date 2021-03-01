//
//  ContentView.swift
//  MyMusic
//
//  Created by Jevon Charles on 2/26/21.
//

import SwiftUI
import StoreKit

struct LibraryView: View {
	@StateObject var libraryViewModel = LibraryViewModel()

	private var menuItems = [
		("Playlists", "music.note.list"),
		("Artists", "music.mic"),
		("Albums", "rectangle.stack"),
		("Songs", "music.note"),
		("Genres", "guitars"),
		("Downloaded", "arrow.down.circle")
	]

	private var columns: [GridItem] = [
		GridItem(.fixed(100), spacing: 16),
		GridItem(.fixed(100), spacing: 16)
	]

	var body: some View {
		NavigationView {
			List {
				ForEach(menuItems, id: \.self.0) { item in
					NavigationLink(destination: Text(item.0)) {
						LibraryMenuItem(imageName: item.1, text: item.0)
					}
				}

//				LazyVGrid(columns: columns, alignment: .center, spacing: 16, pinnedViews: [.sectionHeaders]) {
//					Section(header: Text("Recently Added")
//										.font(.title3)
//										.fontWeight(.bold)
//										.padding(.top, 15)
//					) {
//						ForEach(0...10, id: \.self) { index in
//							Color.blue.frame(width: 100, height: 100, alignment: .center)
//						}
//					}
//				}
			}
			.navigationTitle("Library")
		}
	}
}

struct LibraryMenuItem: View {
	var imageName: String
	var text: String

	var body: some View {
		HStack {
			Image(systemName: imageName)
				.font(.title3)
				.frame(width: 30, height: 10, alignment: .center)
				.foregroundColor(.red)
			Text(text)
				.foregroundColor(.primary)
		}
	}
}

struct LibraryView_Previews: PreviewProvider {
	static var previews: some View {
		LibraryView()
	}
}
