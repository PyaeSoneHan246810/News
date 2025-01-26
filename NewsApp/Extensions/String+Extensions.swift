//
//  String+Extensions.swift
//  NewsApp
//
//  Created by Dylan on 01/01/2025.
//

import Foundation

extension String {
    func toDate(withFormat dateFormat: String = "yyyy-MM-dd'T'HH:mm:ss'Z'") -> Date? {
        let dateFormatter = DateFormatter()
        dateFormatter.dateFormat = dateFormat
        dateFormatter.locale = Locale(identifier: "en_US_POSIX")
        dateFormatter.timeZone = TimeZone(abbreviation: "UTC")
        return dateFormatter.date(from: self)
    }
}
