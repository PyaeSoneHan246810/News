//
//  NetworkError.swift
//  NewsApp
//
//  Created by Dylan on 31/12/2024.
//

import Foundation

enum NetworkingError: LocalizedError {
    case invalidURL
    case badResponse
    case decodingError

    var errorDescription: String? {
        switch self {
        case .invalidURL:
            return "Oops! It seems there's an issue with the address we tried to connect to. Please try again."
        case .badResponse:
            return "We're having trouble connecting to the server. Please check your connection and try again."
        case .decodingError:
            return "Something went wrong while loading the data. Please refresh or try again later."
        }
    }
}
