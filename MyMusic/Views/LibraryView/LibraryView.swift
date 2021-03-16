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
	@State var isExpended = false

	var body: some View {
		NavigationView {
			List {
				MenuItemsView(isExpended: $isExpended)
				if !isExpended {
					MediaVGrid(items: $libraryViewModel.recentlyAdded)
				}
			}
			.environment(\.editMode, .constant(isExpended ? EditMode.active : EditMode.inactive))
			.navigationTitle(Text("Library"))
			.toolbar {
				ToolbarItem(placement: .primaryAction) {
					MenuEditButton(isExpended: $isExpended)
				}
			}
		}
		.navigationViewStyle(StackNavigationViewStyle())
	}
}
