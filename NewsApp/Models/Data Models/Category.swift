//
//  Category.swift
//  NewsApp
//
//  Created by Dylan on 31/12/2024.
//

import Foundation

struct Category: Codable, Identifiable, Equatable, Hashable {
    
    enum CodingKeys: String, CodingKey {
        case emoji
        case name
    }
    
    let emoji: String
    let name: String
    
    init(emoji: String, name: String) {
        self.emoji = emoji
        self.name = name
    }
    
    init(from decoder: Decoder) throws {
        let container = try decoder.container(keyedBy: CodingKeys.self)
        self.emoji = try container.decode(String.self, forKey: .emoji)
        self.name = try container.decode(String.self, forKey: .name)
    }

    func encode(to encoder: Encoder) throws {
        var container = encoder.container(keyedBy: CodingKeys.self)
        try container.encode(emoji, forKey: .emoji)
        try container.encode(name, forKey: .name)
    }
    
    var id: String { name }
}

extension Category: RawRepresentable {
    public init?(rawValue: String) {
        guard let data = rawValue.data(using: .utf8), let result = try? JSONDecoder().decode(Category.self, from: data) else {
            return nil
        }
        self = result
    }
    public var rawValue: String {
        guard let data = try? JSONEncoder().encode(self), let result = String(data: data, encoding: .utf8) else {
            return ""
        }
        return result
    }
}
