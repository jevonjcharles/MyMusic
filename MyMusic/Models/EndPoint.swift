//
//  EndPoint.swift
//  MyMusic
//
//  Created by Jevon Charles on 3/1/21.
//

import Foundation

enum EndPoint {
	static let scheme = "https"
	static let host = "api.music.apple.com"

	case recentlyAdded

	func requestWith(_ userToken: String) -> URLRequest {
		switch self {
			case .recentlyAdded:
				var components = URLComponents()
				components.scheme = EndPoint.scheme
				components.host = EndPoint.host
				components.path = "/v1/me/library/recently-added"
				components.queryItems = [
					URLQueryItem(name: "limit", value: "25")
				]

				var request = URLRequest(url: components.url!)
				request.setValue("Bearer \(developerToken)", forHTTPHeaderField: "Authorization")
				request.setValue(userToken, forHTTPHeaderField: "Music-User-Token")
				return request
		}
	}
}
