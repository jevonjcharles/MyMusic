//
//  NavigationLinkListView.swift
//  MyMusic
//
//  Created by Jevon Charles on 3/3/21.
//

import SwiftUI

struct MenuItemsView: View {
	private var menuItems = [
		("Playlists", "music.note.list"),
		("Artists", "music.mic"),
		("Albums", "rectangle.stack"),
		("Songs", "music.note"),
		("Genres", "guitars"),
		("Downloaded", "arrow.down.circle")
	]

    var body: some View {
			ForEach(menuItems, id: \.self.0) { item in
				NavigationLink(destination: Text(item.0)) {
					LibraryMenuItem(imageName: item.1, text: item.0)
				}
			}
    }
}

