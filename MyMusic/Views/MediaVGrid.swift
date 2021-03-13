//
//  MediaVGrid.swift
//  MyMusic
//
//  Created by Jevon Charles on 3/3/21.
//

import SwiftUI

struct MediaVGrid<T: MediaCollection>: View {
	@Binding var items: [T]

	private var columns: [GridItem] = [
		GridItem(.fixed(180), spacing: 16),
		GridItem(.fixed(180), spacing: 16)
	]

	private var headerText: some View {
		Text("Recently Added")
			.font(.title3)
			.fontWeight(.bold)
			.padding(.top, 15)
	}

	init(items: Binding<[T]>) {
		self._items = items
	}

	var body: some View {
		LazyVGrid(columns: columns, alignment: .leading, spacing: 16, pinnedViews: [.sectionHeaders]) {
			Section(header: headerText) {
				ForEach(items, id: \.id) { item in
						MediaCard(item: item)
				}
			}
		}
	}
}
