//
//  APIHelper.swift
//  MyMusic
//
//  Created by Jevon Charles on 3/1/21.
//

import Foundation
import Combine

struct APIService {
	private static func call<T: Decodable>(_ endPoint: EndPoint, times: Int, with userToken: String) -> AnyPublisher<Response<T>, Error> {
		URLSession.shared.dataTaskPublisher(for: endPoint.requestWith(userToken))
			.map(\.data)
			.decode(type: Payload<T>.self, decoder: JSONDecoder())
			.map(\.items)
			.map { items in
				let nextIndex = times - 1
				if nextIndex != 0 {
					return Response(items: items, nextIndex: nextIndex)
				} else {
					return Response(hasMorePages: false, items: items)
				}
			}
			.eraseToAnyPublisher()
	}

	static func call<T: Decodable>(_ endPoint: EndPoint, with userToken: String, limit maxCount: Int) -> AnyPublisher<[T], Error> {
		let indexPublisher = CurrentValueSubject<Int, Never>((maxCount / 25) + 1) // 25 is MusicKit's max limit

		return indexPublisher
			.flatMap { index in
				return self.call(endPoint, times: index, with: userToken)
			}
			.handleEvents(receiveOutput: { (response: Response) in
				if response.hasMorePages {
					indexPublisher.send(response.nextIndex)
				} else {
					indexPublisher.send(completion: .finished)
				}
			})
			.reduce([T](), { allItems, response in
				return Array((response.items + allItems).prefix(maxCount))
			})
			.eraseToAnyPublisher()
	}
}
