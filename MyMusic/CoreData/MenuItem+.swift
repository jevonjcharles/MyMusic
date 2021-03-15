//
//  MenuItem+.swift
//  MyMusic
//
//  Created by Jevon Charles on 3/14/21.
//

import Foundation

extension MenuItem {
	var unwrappedID: UUID {
		id ?? UUID()
	}

	var unwrappedImageName: String {
		imageName ?? ""
	}

	var unwrappedTitle: String {
		title ?? ""
	}

	var menuType: MenuType {
		MenuType(rawValue: type) ?? MenuType.playlists
	}
}
