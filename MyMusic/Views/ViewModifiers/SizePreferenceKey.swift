//
//  TabBarPreferenceKey.swift
//  MyMusic
//
//  Created by Jevon Charles on 3/20/21.
//

import SwiftUI

struct SizePreferenceKey: PreferenceKey {
	static var defaultValue: CGSize = .zero
	static func reduce(value: inout CGSize, nextValue: () -> CGSize) {
		value = nextValue()
	}
}
