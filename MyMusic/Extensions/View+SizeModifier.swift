//
//  View+SizeModifier.swift
//  MyMusic
//
//  Created by Jevon Charles on 3/20/21.
//

import SwiftUI

extension View {
	func size() -> some View {
		self.modifier(SizeModifier())
	}
}
