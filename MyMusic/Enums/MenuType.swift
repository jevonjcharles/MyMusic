//
//  MenuType.swift
//  MyMusic
//
//  Created by Jevon Charles on 3/14/21.
//

import Foundation

enum MenuType: Int16, CaseIterable, CustomStringConvertible {
	case playlists = 0, artist, songs, albums, tvMovies, musicVideos, genres, compilations, composers,
			 downloaded, homeSharing

	var imageName: String {
		switch self {
			case .playlists: return "music.note.list"
			case .artist: return "music.mic"
			case .songs: return "music.note"
			case .albums: return "rectangle.stack"
			case .tvMovies: return "tv"
			case .musicVideos: return "tv.music.note"
			case .genres: return "guitars"
			case .compilations: return "person.2.square.stack"
			case .composers: return "music.quarternote.3"
			case .downloaded: return "arrow.down.circle"
			case .homeSharing: return "music.note.house"
		}
	}

	var description: String {
		switch self {
			case .playlists: return "Playlists"
			case .artist: return "Artist"
			case .songs: return "Songs"
			case .albums: return "Albums"
			case .tvMovies: return "TV & Movies"
			case .musicVideos: return "Music Videos"
			case .genres: return "Genres"
			case .compilations: return "Compilations"
			case .composers: return "Composers"
			case .downloaded: return "Downloaded"
			case .homeSharing: return "Home Sharing"
		}
	}
}
