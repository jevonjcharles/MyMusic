//
//  NavigationLinkListView.swift
//  MyMusic
//
//  Created by Jevon Charles on 3/3/21.
//

import SwiftUI

struct MenuItemsView: View {
	@EnvironmentObject var coreDataStack: CoreDataStack
	@ObservedObject var libraryViewModel: LibraryViewModel
	@FetchRequest(entity: MenuItem.entity(),
								sortDescriptors: [NSSortDescriptor(keyPath: \MenuItem.position, ascending: true)],
								predicate: nil,
								animation: .spring())
	private var menuItems: FetchedResults<MenuItem>
	@State private var itemSelection: UUID? = nil

	var body: some View {
		ForEach(libraryViewModel.viewable(menuItems)) { item in
			NavigationLink(destination: Text(item.unwrappedTitle)) {
				MenuRowView(menuItem: item, isExpended: $libraryViewModel.isExpended)
			}
			.onTapGesture {
				item.isViewable.toggle()
			}
		}
		.onMove { source, destination in
			libraryViewModel.move(menuItems, source: source, to: destination, andSave: coreDataStack.saveViewContext)
		}
	}

	private func move( from source: IndexSet, to destination: Int) {
		var revisedItems: [MenuItem] = menuItems.map{ $0 }
		revisedItems.move(fromOffsets: source, toOffset: destination)
		for reverseIndex in stride(from: revisedItems.count - 1, through: 0, by: -1 ) {
			revisedItems[reverseIndex].position = Int16(reverseIndex)
		}
		coreDataStack.saveViewContext()
	}
}

