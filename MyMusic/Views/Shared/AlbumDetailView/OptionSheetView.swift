//
//  OptionSheet.swift
//  MyMusic
//
//  Created by Jevon Charles on 4/12/21.
//

import SwiftUI

struct OptionSheetView: View {
	@EnvironmentObject var musicController: MusicController
	@Binding var isShowingSheet: Bool
}
// Body
extension OptionSheetView {
	var body: some View {
		GeometryReader { geometry in
			VStack {
				Spacer()
					.frame(width: geometry.size.width, height: geometry.size.height * 0.5, alignment: .center)
					.contentShape(Rectangle())
					.onTapGesture {
						isShowingSheet.toggle()
						print("TAP")
					}
				ZStack {
					RoundedRectangle(cornerRadius: 8)
						.fill(Color(UIColor.systemGray6))
					VStack {
						header()
						Divider()
						List {
							Group {
								Text("Copy")
								Text("Share")
							}
						}
						.listStyle(InsetGroupedListStyle())
					}
				}
			}
			.clearBackground()
		}
	}
}
// Header
extension OptionSheetView {
	@ViewBuilder
	private func header() -> some View {
		HStack {
			ArtworkView(song: $musicController.song, size: .extraSmall)
			VStack(alignment: .leading) {
				Text(musicController.song?.albumTitle ?? "Unknown")
					.font(.subheadline)
					.fontWeight(.semibold)
					.foregroundColor(.primary)
				Text(musicController.song?.artistName ?? "Unknown")
					.font(.caption)
					.foregroundColor(.secondary)
			}
			Spacer()
			Button(action: {
				isShowingSheet.toggle()
			}, label: {
				ZStack {
					Circle()
					Image(systemName: "xmark")
				}
				.font(.title)
			})
		}
		.padding()
	}
}
