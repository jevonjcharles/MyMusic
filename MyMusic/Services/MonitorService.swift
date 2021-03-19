//
//  Reachability.swift
//  MyMusic
//
//  Created by Jevon Charles on 3/18/21.
//

import Network
import Combine

final class MonitorService: ObservableObject {
	@Published var isConnected: Bool = false
	private let monitor = NWPathMonitor()

	init() {
		monitor.pathUpdateHandler = {[weak self] path in
			guard let self = self else { return }
			switch path.status {
				case .satisfied: self.isConnected = true
				default: self.isConnected = false
			}
		}
		monitor.start(queue: DispatchQueue.main)
	}
}
