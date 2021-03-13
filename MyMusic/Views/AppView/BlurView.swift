//
//  BlurView.swift
//  MyMusic
//
//  Created by Jevon Charles on 3/3/21.
//

import SwiftUI

struct BlurView: UIViewRepresentable {
	var effect: UIVisualEffect?
	func makeUIView(context: UIViewRepresentableContext<Self>) -> UIVisualEffectView { UIVisualEffectView() }
	func updateUIView(_ uiView: UIVisualEffectView, context: UIViewRepresentableContext<Self>) { uiView.effect = effect }
}
