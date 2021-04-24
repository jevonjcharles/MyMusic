//
//  AppView.swift
//  MyMusic
//
//  Created by Jevon Charles on 2/27/21.
//

import SwiftUI

struct AppView: View {
	@Environment(\.colorScheme) var colorScheme
	@StateObject var musicController = MusicController()
	@StateObject var monitorService = MonitorService()
	@State private var offset: CGFloat = 0
}
// Body
extension AppView {
	var body: some View {
		GeometryReader { geometry in
			ZStack {
				TabView {
					LibraryView()
						.size()
						.tabItem {
							Label("Library", systemImage: "rectangle.stack.fill")
						}
				}
				.accentColor(.red)
				.environmentObject(musicController)
				.environmentObject(monitorService)
				.onPreferenceChange(SizePreferenceKey.self, perform: { offset = geometry.size.height - $0.height })
				nowPlaying()
			}
		}
		//		.alert(isPresented: $alertViewModel.isPresented) {
		//			alertViewModel.alert
		//		}
	}
}
// NowPlaying
extension AppView {
	private var effect: UIBlurEffect {
		UIBlurEffect(style: colorScheme == .light ? .systemMaterialLight : .prominent)
	}

	@ViewBuilder
	private func nowPlaying() -> some View {
		if musicController.song != nil {
			VStack {
				Spacer()
				VStack(alignment: .leading, spacing: 0) {
					ZStack(alignment: .leading) {
						BlurView(effect: effect)
						HStack(alignment: .center) {
							ArtworkView(song: $musicController.song, size: .small)
							Text(musicController.song?.title ?? "Unknown")
								.padding()
							Spacer()
							HStack(spacing: 20) {
								button(action: musicController.playOrPause, imageName: musicController.playButtonImageName)
								button(action: musicController.skipToNextItem , imageName: "forward.fill")
							}
						}
						.padding(.horizontal, 20)
					}
				}
				.frame(height: 66)
				.offset(y: -offset)
			}
		}
	}

	@ViewBuilder
	private func button(action: @escaping () -> Void, imageName: String) -> some View {
		Button(action: action, label: {
			Image(systemName: imageName)
				.font(.title2)
				.foregroundColor(.primary)
				.frame(width: 30, height: 30)
		})
	}
}

struct AppView_Previews: PreviewProvider {
	static var previews: some View {
		let context = CoreDataStack.preview.viewContext

		AppView()
			.environment(\.managedObjectContext, context)
	}
}
