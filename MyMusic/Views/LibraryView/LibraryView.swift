//
//  ContentView.swift
//  MyMusic
//
//  Created by Jevon Charles on 2/26/21.
//

import SwiftUI

struct LibraryView: View {
	@EnvironmentObject var coreDataStack: CoreDataStack
	@StateObject var libraryViewModel = LibraryViewModel()
	@FetchRequest(entity: MenuItem.entity(),
								sortDescriptors: [NSSortDescriptor(keyPath: \MenuItem.position, ascending: true)],
								predicate: nil,
								animation: .spring())
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
			List {
				menuItemsView()
				if !libraryViewModel.isExpended {
					albumGrid()
				}
			}
			.environment(\.editMode, .constant(libraryViewModel.isExpended ? EditMode.active : EditMode.inactive))
			.navigationTitle(Text("Library"))
			.toolbar {
				ToolbarItem(placement: .primaryAction) {
					editButton()
				}
			}
		}
		.navigationViewStyle(StackNavigationViewStyle())
	}
}
// MenuItemsForEach
extension LibraryView {
	@ViewBuilder
	private func menuItemsView() -> some View {
		ForEach(libraryViewModel.viewable(menuItems)) { item in
			NavigationLink(destination: Text(item.unwrappedTitle)) {
				menu(item)
			}
		}
		.onMove { source, destination in
			libraryViewModel.move(menuItems, source: source, to: destination, andSave: coreDataStack.saveViewContext)
		}
	}
}
// MenuRowView
extension LibraryView {
	@ViewBuilder
	private func menu(_ item: MenuItem) -> some View {
		HStack {
			if item.isViewable && libraryViewModel.isExpended {
				Image(systemName: "checkmark.circle.fill")
					.transition(.move(edge: libraryViewModel.isExpended ? .leading : .trailing))
					.font(.title2)
					.frame(width: 30, height: 41, alignment: .center)
					.foregroundColor(.red)
			} else if libraryViewModel.isExpended {
				Spacer()
					.frame(width: 30, height: 41, alignment: .center)
			}
			Image(systemName: item.unwrappedImageName)
				.font(.title2)
				.frame(width: 30, height: 41, alignment: .center)
				.foregroundColor(.red)
			Text(item.unwrappedTitle)
				.font(.title2)
				.foregroundColor(.primary)
			Spacer()
		}
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
				ForEach(libraryViewModel.recentlyAddedAlbums, id: \.id) { album in
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
				libraryViewModel.isExpended.toggle()
			}
		}, label: {
			Text(libraryViewModel.buttonTitle)
				.foregroundColor(.red)
		})
	}
}
