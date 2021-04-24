//
//  View+ClearBackground.swift
//  MyMusic
//
//  Created by Jevon Charles on 4/12/21.
//

import SwiftUI

extension View {
	func clearBackground()->some View {
		self.modifier(ClearBackgroundViewModifier())
	}
}
