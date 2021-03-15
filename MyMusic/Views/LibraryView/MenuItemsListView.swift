//
//  MenuItemsListView.swift
//  MyMusic
//
//  Created by Jevon Charles on 3/14/21.
//

import SwiftUI

struct MenuItemsListView: View {
	@FetchRequest(entity: MenuItem.entity(),
								sortDescriptors: [NSSortDescriptor(keyPath: \MenuItem.type, ascending: true)],
								predicate: nil,
								animation: .spring())
	private var menuItems: FetchedResults<MenuItem>
	@State private var selectedItems = Set<MenuItem>()

    var body: some View {
			List(menuItems, selection: $selectedItems) { item in
				Text(item.unwrappedTitle)
			}
    }
}
