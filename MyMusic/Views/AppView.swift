//
//  AppView.swift
//  MyMusic
//
//  Created by Jevon Charles on 2/27/21.
//

import SwiftUI

struct AppView: View {
//	@StateObject private var musicKitService: MusicKitService
//	@StateObject private var alertViewModel: AlertViewModel
//
//	init() {
//		let alertViewModel = AlertViewModel()
//		let musicKitService = StateObject(wrappedValue: MusicKitService(alertViewModel: alertViewModel))
//		_musicKitService = musicKitService
//		_alertViewModel = StateObject(wrappedValue: alertViewModel)
//	}

	@StateObject var coreDataStack = CoreDataStack()
	@StateObject var musicController = MusicController()
	@StateObject var monitorService = MonitorService()
	@State private var offset: CGFloat = 0

	var body: some View {
		GeometryReader { geometry in
			TabView {
				LibraryView()
					.size()
					.tabItem {
						Label("Library", systemImage: "rectangle.stack.fill")
					}
				//				.environmentObject(musicKitService)
			}
			.accentColor(.red)
			.environmentObject(coreDataStack)
			.environmentObject(musicController)
			.environmentObject(monitorService)
			.environment(\.managedObjectContext, coreDataStack.viewContext)
			.onPreferenceChange(SizePreferenceKey.self, perform: { offset = geometry.size.height - $0.height })
			.overlay(NowPlayingView(offset: offset).environmentObject(musicController), alignment: .bottom)
		}

//		.alert(isPresented: $alertViewModel.isPresented) {
//			alertViewModel.alert
//		}
	}
}

struct AppView_Previews: PreviewProvider {
	static var previews: some View {
		AppView()
	}
}
