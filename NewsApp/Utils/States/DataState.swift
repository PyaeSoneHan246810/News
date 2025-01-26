//
//  DataState.swift
//  NewsApp
//
//  Created by Dylan on 13/01/2025.
//

import Foundation

enum DataState<T> {
    case loading
    case loaded(T)
    case error(Error)
}
