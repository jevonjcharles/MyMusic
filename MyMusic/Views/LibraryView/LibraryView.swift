//
//  ContentView.swift
//  MyMusic
//
//  Created by Jevon Charles on 2/26/21.
//

import SwiftUI

struct LibraryView: View {
	@StateObject var libraryViewModel = LibraryViewModel()

	var body: some View {
		NavigationView {
			List {
				MenuItemsView(libraryViewModel: libraryViewModel)
				if !libraryViewModel.isExpended {
					AlbumGrid(albums: $libraryViewModel.recentlyAddedAlbums)
				}
			}
			.environment(\.editMode, .constant(libraryViewModel.isExpended ? EditMode.active : EditMode.inactive))
			.navigationTitle(Text("Library"))
			.toolbar {
				ToolbarItem(placement: .primaryAction) {
					MenuEditButton(libraryViewModel: libraryViewModel)
				}
			}
		}
		.navigationViewStyle(StackNavigationViewStyle())
	}
}
