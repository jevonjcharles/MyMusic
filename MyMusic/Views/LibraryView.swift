//
//  ContentView.swift
//  MyMusic
//
//  Created by Jevon Charles on 2/26/21.
//

import SwiftUI
import StoreKit

struct LibraryView: View {
	@StateObject var libraryViewModel = LibraryViewModel()
	
	var body: some View {
		NavigationView {
			List {
				NavigationLink(destination: Text("Playlists")) {
					LibraryListItem(imageName: "music.note.list", text: "Playlists")
				}

				NavigationLink(destination: Text("Artists")) {
					LibraryListItem(imageName: "music.mic", text: "Artists")
				}

				NavigationLink(destination: Text("Albums")) {
					LibraryListItem(imageName: "rectangle.stack", text: "Albums")
				}

				NavigationLink(destination: Text("Songs")) {
					LibraryListItem(imageName: "music.note", text: "Songs")
				}

				NavigationLink(destination: Text("Genres")) {
					LibraryListItem(imageName: "guitars", text: "Genres")
				}

				NavigationLink(destination: Text("Downloaded")) {
					LibraryListItem(imageName: "arrow.down.circle", text: "Downloaded")
				}

				Text("Recently Added")
					.font(.title3)
					.fontWeight(.bold)
					.padding(.top, 15)
			}
			.navigationTitle("Library")
		}
	}
}

struct LibraryListItem: View {
	var imageName: String
	var text: String

	var body: some View {
		HStack {
			Image(systemName: imageName)
				.font(.title3)
				.frame(width: 30, height: 10, alignment: .center)
				.foregroundColor(.red)
			Text(text)
				.foregroundColor(.primary)
		}
	}
}

struct ListSeparatorStyle: ViewModifier {

	let style: UITableViewCell.SeparatorStyle

	func body(content: Content) -> some View {
		content
			.onAppear() {
				UITableView.appearance().separatorStyle = self.style
			}
	}
}

extension View {

	func listSeparatorStyle(style: UITableViewCell.SeparatorStyle) -> some View {
		ModifiedContent(content: self, modifier: ListSeparatorStyle(style: style))
	}
}
