//
//  ContentView.swift
//  MyMusic
//
//  Created by Jevon Charles on 2/26/21.
//

import SwiftUI

struct LibraryView: View {
	@StateObject private var viewModel = LibraryViewModel()
	@FetchRequest(sortDescriptors: [])
	private var menuItems: FetchedResults<MenuItem>
	private var columns: [GridItem] = [
		GridItem(.fixed(180), spacing: 16),
		GridItem(.fixed(180), spacing: 16)
	]
}
// Body
extension LibraryView {
	var body: some View {
		NavigationView {
			List(selection: $viewModel.selectedMenuItems) {
				MenuItemList(viewModel: viewModel)
				if viewModel.editMode == .inactive {
					albumGrid()
				}
			}
			.navigationTitle(Text("Library"))
			.toolbar {
				ToolbarItem(placement: .primaryAction) {
					editButton()
				}
			}
			.environment(\.editMode, $viewModel.editMode)
		}
		.navigationViewStyle(StackNavigationViewStyle())
		.environmentObject(viewModel)
	}
}
// AlbumGrid
extension LibraryView {
	private var headerText: some View {
		Text("Recently Added")
			.font(.title3)
			.fontWeight(.bold)
			.padding(.top, 15)
	}

	@ViewBuilder
	private func albumGrid() -> some View {
		LazyVGrid(columns: columns, alignment: .leading, spacing: 16, pinnedViews: [.sectionHeaders]) {
			Section(header: headerText) {
				ForEach(viewModel.recentlyAddedAlbums, id: \.id) { album in
					AlbumCard(album: album)
				}
			}
		}
	}
}
// EditButton
extension LibraryView {
	@ViewBuilder
	private func editButton() -> some View {
		Button(action: {
			withAnimation {
				viewModel.set(menuItems)
				viewModel.toggleEditMode()
			}
		}, label: {
			Text(viewModel.editMode == .inactive ? "Edit" : "Done")
		})
	}
}
