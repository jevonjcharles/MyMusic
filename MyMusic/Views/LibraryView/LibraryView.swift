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

	var body: some View {
		NavigationView {
			List {
				MenuItemsView()
				MediaVGrid(items: $libraryViewModel.recentlyAdded)
			}
			.navigationTitle(Text("Library"))
			.toolbar {
				ToolbarItem(placement: .primaryAction) {
					EditButton()
				}
			}
		}
		.navigationViewStyle(StackNavigationViewStyle())
	}
}
