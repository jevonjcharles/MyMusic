//
//  ClearBackgroundViewModifier.swift
//  MyMusic
//
//  Created by Jevon Charles on 4/12/21.
//

import SwiftUI

struct ClearBackgroundViewModifier: ViewModifier {
	func body(content: Content) -> some View {
		content
			.background(ClearBackgroundView())
	}
}
