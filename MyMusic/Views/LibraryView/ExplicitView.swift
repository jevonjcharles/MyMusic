//
//  ExplicitView.swift
//  MyMusic
//
//  Created by Jevon Charles on 3/18/21.
//

import SwiftUI

struct ExplicitView: View {
	var body: some View {
		ZStack {
			RoundedRectangle(cornerRadius: 2)
				.foregroundColor(.gray)
				.frame(width: 12, height: 12)
			Text("E")
				.foregroundColor(.black)
				.font(.caption2)
				.fontWeight(.bold)
		}
	}
}
