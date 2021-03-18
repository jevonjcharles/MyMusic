//
//  MediaDetailView.swift
//  MyMusic
//
//  Created by Jevon Charles on 3/11/21.
//

import SwiftUI
import MediaPlayer

struct MediaDetailView<T: MediaCollection>: View {
	@EnvironmentObject var player: Player
	var item: T
	var playbackDuration: Int {
		item.songs.map(\.playbackDuration).reduce(0, +) / 60
	}

	var body: some View {
		ScrollView {
			MediaHeaderView(item: item)
			Buttons(play: play, shuffle: shuffle)
				.padding()
			Divider()
				.offset(x: 3, y: 0)
				.padding(.top, 10)
			ForEach(item.songs) { song in
				VStack(alignment: .leading) {
					HStack {
						Text("\(song.trackNumber)")
						Text(song.title)
						if song.isExplicit {
							ExplicitView()
						}
						Spacer()

						if song.isCloudItem {
							CloudView(download: download)
						}
					}
					.padding(.horizontal, 20)
					Divider()
						.offset(x: 40, y: 0)
				}
			}

			HStack {
				VStack(alignment: .leading) {
					Text("\(item.songs.count) \(item.songs.count > 1 ? "songs" : "song") \(playbackDuration) \(playbackDuration > 1 ? "minutes" : "minute")")
					Text("℗ \(item.releaseDate)")
						.font(.footnote)
				}
				.padding()
				Spacer()
			}
			.foregroundColor(.secondary)
		}
		.padding(.top, 1)
	}

	private func play() {
		print(#function)
		player.queue(item.songs.map(\.storeID), and: true)
	}

	private func shuffle() {

	}

	private func download() {

	}
}

struct MediaHeaderView<T: MediaCollection>: View {
	var item: T

	var body: some View {
		VStack(spacing: 15) {
			HStack {
				Spacer()
				ArtworkView(artwork: item.artwork, size: .medium)
				Spacer()
			}

			VStack {
				Text(item.albumTitle)
					.foregroundColor(.primary)
					.fontWeight(.bold)
					.font(.title3)
					.multilineTextAlignment(.center)

				Text(item.artistName)
					.foregroundColor(.red)
					.font(.title3)

				Text(item.genre)
					.foregroundColor(.secondary)
					.font(.caption)
			}
			.frame(width: 320)
		}
	}
}

struct Buttons: View {
	var play: () -> Void
	var shuffle: () -> Void

	var body: some View {
		HStack(spacing: 20) {
			Button(action: play, label: {
				HStack {
					Image(systemName: "play.fill")
					Text("Play")
						.fontWeight(.bold)
				}
				.foregroundColor(.red)
			})
			.frame(height: 15)
			.frame(maxWidth: .infinity)
			.padding()
			.background(Color.gray.opacity(0.2))
			.cornerRadius(8)

			Button(action: shuffle, label: {
				HStack {
					Image(systemName: "shuffle")
					Text("Shuffle")
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
}

struct ExplicitView: View {
	var body: some View {
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
}

struct CloudView: View {
	var download: () -> Void

	var body: some View {
		Button(action: download, label: {
			Image(systemName: "icloud.and.arrow.down")
				.foregroundColor(.red)
				.font(Font.subheadline.weight(.bold))
		})
	}
}
