//
//  Response.swift
//  MyMusic
//
//  Created by Jevon Charles on 3/1/21.
//

import Foundation

struct Response<T: Decodable>{
	var hasMorePages = true
	var items: [T]
	var nextIndex = 0
}
