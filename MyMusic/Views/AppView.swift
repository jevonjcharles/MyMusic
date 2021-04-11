//
//  AppView.swift
//  MyMusic
//
//  Created by Jevon Charles on 2/27/21.
//

import SwiftUI

struct AppView: View {
	@Environment(\.colorScheme) var colorScheme
	@StateObject var coreDataStack = CoreDataStack()
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
					LibraryView(coreDataStack: coreDataStack)
						.size()
						.tabItem {
							Label("Library", systemImage: "rectangle.stack.fill")
						}
				}
				.accentColor(.red)
				.environmentObject(coreDataStack)
				.environmentObject(musicController)
				.environmentObject(monitorService)
				.environment(\.managedObjectContext, coreDataStack.viewContext)
				.onPreferenceChange(SizePreferenceKey.self, perform: { offset = geometry.size.height - $0.height })
				if musicController.song != nil {
					VStack {
						Spacer()
						nowPlaying()
					}
					.animation(.easeIn)
				}
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
		VStack(alignment: .leading, spacing: 0) {
			ZStack {
				BlurView(effect: effect)
				HStack(alignment: .center) {
					ArtworkView(song: $musicController.song, size: .small)
					Text(musicController.song?.title ?? "Unknown")
						.padding()
					Spacer()
					HStack(spacing: 20) {
						button(action: { print("PLAY") }, imageName: musicController.playButtonImageName)
						button(action: { print("NEXT") } , imageName: "forward.fill")
					}
				}
				.padding(.horizontal, 20)
			}
		}
		.frame(height: 66)
		.offset(y: -offset)
	}

	@ViewBuilder
	private func button(action: @escaping () -> Void, imageName: String) -> some View {
		Button(action: action, label: {
			Image(systemName: imageName)
				.font(.title)
				.foregroundColor(.primary)
				.frame(width: 50, height: 50)
		})
	}
}

struct AppView_Previews: PreviewProvider {
	static var previews: some View {
		AppView()
	}
}
