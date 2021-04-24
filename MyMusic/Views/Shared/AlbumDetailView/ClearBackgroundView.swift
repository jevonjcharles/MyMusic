//
//  ClearBackgroundView.swift
//  MyMusic
//
//  Created by Jevon Charles on 4/12/21.
//

import SwiftUI

struct ClearBackgroundView: UIViewRepresentable {
	func makeUIView(context: Context) -> some UIView {
		let view = UIView()
		DispatchQueue.main.async {
			view.superview?.superview?.backgroundColor = .clear
		}
		return view
	}
	func updateUIView(_ uiView: UIViewType, context: Context) {	}
}
