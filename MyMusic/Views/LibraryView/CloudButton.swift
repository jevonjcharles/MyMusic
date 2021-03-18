//
//  CloudButton.swift
//  MyMusic
//
//  Created by Jevon Charles on 3/18/21.
//

import SwiftUI

struct CloudButton: View {
	var download: () -> Void

	var body: some View {
		Button(action: download, label: {
			Image(systemName: "icloud.and.arrow.down")
				.foregroundColor(.red)
				.font(Font.subheadline.weight(.bold))
		})
	}
}
