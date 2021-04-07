//
//  MediaDetailView.swift
//  MyMusic
//
//  Created by Jevon Charles on 3/11/21.
//

import SwiftUI

struct AlbumDetailView: View {
	@EnvironmentObject var musicController: MusicController
	@EnvironmentObject var monitorService: MonitorService
	@StateObject var viewModel = AlbumDetailViewModel()
	@State var isShowingSheet = false
	@State var isShowingAlert = false
	var album: Album
}
// Body
extension AlbumDetailView {
	var body: some View {
		ScrollView {
			headerView()
			controlButtons()
			Divider()
				.offset(x: 3, y: 0)
				.padding(.top, 10)
			songList()
			footer()
		}
		.padding(.top, 1)
		.toolbar {
			ToolbarItem(placement: .primaryAction) {
				toolBarButtons()
			}
		}
	}
}
// HeaderView
extension AlbumDetailView {
	@ViewBuilder
	private func headerView() -> some View {
		VStack(alignment: .center, spacing: 1) {
			ArtworkView(artwork: album.artwork, size: .medium)
				.padding(.bottom, 10)
			Text(album.albumTitle)
				.foregroundColor(.primary)
				.fontWeight(.bold)
				.font(.title3)
				.multilineTextAlignment(.center)
			Text(album.artistName)
				.foregroundColor(.red)
				.font(.title3)
			Text("\(album.genre.uppercased()) • \(album.releaseDate)")
				.foregroundColor(.secondary)
				.font(.caption2)
				.fontWeight(.bold)
				.padding(.top, 2)
		}
	}
}
// ControlButtons
extension AlbumDetailView {
	@ViewBuilder
	private func controlButtons() -> some View {
		HStack(spacing: 20) {
			button(action: {
				musicController.queue(album.songs.map(\.storeID))
				musicController.play()
			}, imageName: "play.fill", title: "Play")
			button(action: {

			}, imageName: "shuffle", title: "Shuffle")
		}
		.padding()
	}

	@ViewBuilder
	private func button(action: @escaping () -> Void, imageName: String, title: String) -> some View {
		Button(action: action, label: {
			HStack {
				Image(systemName: imageName)
				Text(title)
					.fontWeight(.bold)
			}
			.foregroundColor(.red)
		})
		.frame(height: 15)
		.frame(maxWidth: .infinity)
		.padding()
		.background(Color.gray.opacity(0.2))
		.cornerRadius(8)
	}
}
// SongList
extension AlbumDetailView {
	@ViewBuilder
	private func songList() -> some View {
		ForEach(album.songs) { song in
			LazyVStack(alignment: .leading) {
				cellFor(song)
				Divider()
					.offset(x: 40, y: 0)
			}
			.contentShape(Rectangle())
			.onTapGesture {
				viewModel.queue(album.songs, from: song.trackNumber, with: musicController)
			}
		}
	}

	@ViewBuilder
	private func cellFor(_ song: Song) -> some View {
		HStack(alignment: .bottom) {
			if musicController.song == song && musicController.playbackState == .playing {
				BarsView()
			} else {
				Text("\(song.trackNumber)")
					.foregroundColor(.secondary)
			}
			Text(song.title)
				.foregroundColor(.primary)
				.padding(.leading, 10)
			if song.isExplicit {
				explicit()
			}
			Spacer()
			if song.isCloudItem {
				cloudButton()
			}
		}
		.padding(.vertical, 6)
		.padding(.horizontal, 20)
	}

	@ViewBuilder
	private func explicit() -> some View {
		ZStack {
			RoundedRectangle(cornerRadius: 2)
				.foregroundColor(.gray)
				.frame(width: 12, height: 12)
			Text("E")
				.foregroundColor(.black)
				.font(.caption2)
				.fontWeight(.bold)
		}
	}

	@ViewBuilder
	private func cloudButton() -> some View {
		Button(action: viewModel.download, label: {
			Image(systemName: "icloud.and.arrow.down")
				.foregroundColor(.red)
				.font(Font.subheadline.weight(.bold))
		})
	}
}
// Footer
extension AlbumDetailView {
	@ViewBuilder
	private func footer() -> some View {
		HStack {
			VStack(alignment: .leading) {
				Text("\(album.songs.count) \(album.songs.count > 1 ? "songs" : "song") \(album.playbackDuration) \(album.playbackDuration > 1 ? "minutes" : "minute")")
				Text("℗ \(album.releaseDate)")
					.font(.footnote)
			}
			.padding()
			Spacer()
		}
		.foregroundColor(.secondary)
	}
}
// ToolBarButtons
extension AlbumDetailView {
	@ViewBuilder
	private func toolBarButtons() -> some View {
		HStack(spacing: 23) {
			if monitorService.isConnected {
				AlbumDetailToolBarButton(flag: $isShowingAlert, imageName: "checkmark")
			} else {
				Spacer(minLength: 0)
			}
			AlbumDetailToolBarButton(flag: $isShowingSheet, imageName: "ellipsis")
		}
	}
}
