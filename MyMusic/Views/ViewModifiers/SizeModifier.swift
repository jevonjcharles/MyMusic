//
//  SizeModifier.swift
//  MyMusic
//
//  Created by Jevon Charles on 3/20/21.
//

import SwiftUI

struct SizeModifier: ViewModifier {
	func body(content: Content) -> some View {
		GeometryReader { geo in
			content.preference(key: SizePreferenceKey.self, value: geo.size)
		}
	}
}
