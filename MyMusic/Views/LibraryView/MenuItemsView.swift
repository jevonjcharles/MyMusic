//
//  NavigationLinkListView.swift
//  MyMusic
//
//  Created by Jevon Charles on 3/3/21.
//

import SwiftUI

struct MenuItemsView: View {
	@Binding var isExpended: Bool
	@FetchRequest(entity: MenuItem.entity(),
								sortDescriptors: [NSSortDescriptor(keyPath: \MenuItem.type, ascending: true)],
								predicate: NSPredicate(format: "isViewable == %@", NSNumber(value: true)),
								animation: .spring())
	private var viewableMenuItems: FetchedResults<MenuItem>

	@FetchRequest(entity: MenuItem.entity(),
								sortDescriptors: [NSSortDescriptor(keyPath: \MenuItem.type, ascending: true)],
								predicate: nil,
								animation: .spring())
	private var menuItems: FetchedResults<MenuItem>

	@State private var selectedItems = Set<MenuItem>()

	var body: some View {
		if isExpended {
			List(menuItems, selection: $selectedItems) { item in
				Text(item.unwrappedTitle)
			}
		} else {
			ForEach(viewableMenuItems) { item in
				NavigationLink(destination: Text(item.unwrappedTitle)) {
					MenuRowView(menuItem: item)
				}
			}
		}
	}
}

