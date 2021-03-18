//
//  MediaVGrid.swift
//  MyMusic
//
//  Created by Jevon Charles on 3/3/21.
//

import SwiftUI

struct AlbumGrid: View {
	@Binding var albums: [Album]

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

	init(albums: Binding<[Album]>) {
		self._albums = albums
	}
	
	var body: some View {
		LazyVGrid(columns: columns, alignment: .leading, spacing: 16, pinnedViews: [.sectionHeaders]) {
			Section(header: headerText) {
				ForEach(albums, id: \.id) { album in
						AlbumCard(album: album)
				}
			}
		}
	}
}
