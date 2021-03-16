//
//  NavigationLinkListView.swift
//  MyMusic
//
//  Created by Jevon Charles on 3/3/21.
//

import SwiftUI

struct MenuItemsView: View {
	@EnvironmentObject var coreDataStack: CoreDataStack
	@Binding var isExpended: Bool
	@FetchRequest(entity: MenuItem.entity(),
								sortDescriptors: [NSSortDescriptor(keyPath: \MenuItem.position, ascending: true)],
								predicate: NSPredicate(format: "isViewable == %@", NSNumber(value: true)),
								animation: .spring())
	private var viewableMenuItems: FetchedResults<MenuItem>

	@FetchRequest(entity: MenuItem.entity(),
								sortDescriptors: [NSSortDescriptor(keyPath: \MenuItem.position, ascending: true)],
								predicate: nil,
								animation: .spring())
	private var menuItems: FetchedResults<MenuItem>
	@State private var itemSelection: UUID? = nil

	var body: some View {
		ForEach(isExpended ? menuItems : viewableMenuItems) { item in
			NavigationLink(destination: Text(item.unwrappedTitle)) {
				MenuRowView(menuItem: item, isExpended: $isExpended)
			}
			.onTapGesture {
				item.isViewable.toggle()
			}
		}
		.onMove(perform: move)
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

