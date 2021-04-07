//
//  BarsView.swift
//  MyMusic
//
//  Created by Jevon Charles on 4/7/21.
//

import SwiftUI

struct BarsView: View {
	var body: some View {
		HStack(alignment: .bottom, spacing: 1) {
			ForEach(0...3, id: \.self) { _ in
				Bar(time: DispatchTime.now() + Double.random(in: 0.1...0.5))
			}
		}
	}
}

struct Bar: View {
	@State private var height: CGFloat = 3
	private var animation: Animation {
		Animation
			.linear(duration: Double.random(in: 0.2...0.7))
			.repeatForever(autoreverses: true)
	}
	var id = UUID()
	var time: DispatchTime

	var body: some View {
		Rectangle()
			.fill(Color.red)
			.frame(width: 3, height: height, alignment: .bottom)
			.onAppear(perform: {
				DispatchQueue.main.asyncAfter(deadline: time) {
					withAnimation(animation) {
						height = 10
					}
				}
			})
	}
}

struct BarsView_Previews: PreviewProvider {
    static var previews: some View {
        BarsView()
    }
}
