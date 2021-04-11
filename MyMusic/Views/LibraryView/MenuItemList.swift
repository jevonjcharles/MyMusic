//
//  MenuItemList.swift
//  MyMusic
//
//  Created by Jevon Charles on 4/7/21.
//

import SwiftUI

struct MenuItemList: View {
	@ObservedObject var viewModel: LibraryViewModel
	@FetchRequest private var menuItems: FetchedResults<MenuItem>

	init(viewModel: LibraryViewModel) {
		self.viewModel = viewModel
		self._menuItems = FetchRequest(entity: MenuItem.entity(),
															 sortDescriptors: [NSSortDescriptor(keyPath: \MenuItem.position, ascending: true)],
															 predicate: viewModel.editMode == .active ? nil : NSPredicate(format: "isViewable == %@", NSNumber(value: true)))
	}
}
// Body
extension MenuItemList {
	var body: some View {
		ForEach(menuItems, id: \.self) { menuItem in
			HStack {
				Image(systemName: menuItem.unwrappedImageName)
					.font(.title2)
					.frame(width: 30, height: 41, alignment: .center)
					.foregroundColor(.red)
				Text(menuItem.unwrappedTitle)
					.font(.title2)
					.foregroundColor(.primary)
				Spacer()
			}
			.overlay(NavigationLink(destination: Text(menuItem.unwrappedTitle),label: {}).opacity(viewModel.editMode == .active ? 0 : 1))
			.onAppear {
				viewModel.insert(menuItems)
			}
		}
		.onMove { source, destination in
			viewModel.move(menuItems, from: source, to: destination)
		}
	}
}
