//
//  ContentView.swift
//  MyMusic
//
//  Created by Jevon Charles on 2/26/21.
//

import SwiftUI
import StoreKit
import MediaPlayer

struct LibraryView: View {
//	@EnvironmentObject var musicKitService: MusicKitService
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
		GridItem(.fixed(180), spacing: 16),
		GridItem(.fixed(180), spacing: 16)
	]

	var body: some View {
		NavigationView {
			List {
				ForEach(menuItems, id: \.self.0) { item in
					NavigationLink(destination: Text(item.0)) {
						LibraryMenuItem(imageName: item.1, text: item.0)
					}
				}

				LazyVGrid(columns: columns, alignment: .leading, spacing: 16, pinnedViews: [.sectionHeaders]) {
					Section(header: Text("Recently Added")
														.font(.title3)
														.fontWeight(.bold)
														.padding(.top, 15)
					) {
						ForEach(libraryViewModel.recentlyAdded, id: \.id) { mediaItem in
							VStack(alignment: .leading) {
								Color.gray.frame(width: 180, height: 180, alignment: .center)
									.cornerRadius(8)

								Text(mediaItem.title)
									.lineLimit(1)
									.font(.body)
								Text(mediaItem.artist)
									.font(.body)
							}
							.foregroundColor(.primary)
						}
					}
				}
				.padding(.bottom, 50)
			}
			.navigationTitle(Text("Library"))
		}
		.navigationViewStyle(StackNavigationViewStyle())
	}
}

struct LibraryMenuItem: View {
	var imageName: String
	var text: String

	var body: some View {
		HStack {
			Image(systemName: imageName)
				.font(.title3)
				.frame(width: 30, height: 41, alignment: .center)
				.foregroundColor(.red)
			Text(text)
				.font(.title2)
				.foregroundColor(.primary)
		}
	}
}
