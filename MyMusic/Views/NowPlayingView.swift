//
//  NowPlayingView.swift
//  MyMusic
//
//  Created by Jevon Charles on 3/20/21.
//

import SwiftUI

struct NowPlayingView: View {
	@Environment(\.colorScheme) var colorScheme
	@EnvironmentObject var musicController: MusicController
	var offset: CGFloat
	private var effect: UIBlurEffect {
		UIBlurEffect(style: colorScheme == .light ? .systemMaterialLight : .prominent)
	}

	var body: some View {
		VStack(alignment: .leading, spacing: 0) {
			ZStack {
				BlurView(effect: effect)
				HStack(alignment: .center) {
					ArtworkView(song: $musicController.song, size: .small)
				}
			}
		}
		.frame(height: 60)
		.offset(y: -offset)
	}
}
