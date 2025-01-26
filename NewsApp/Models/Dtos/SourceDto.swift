//
//  SourceDto.swift
//  NewsApp
//
//  Created by Dylan on 31/12/2024.
//

import Foundation

struct SourceDto: Decodable {
    
    enum CodingKeys: String, CodingKey {
        case id = "id"
        case name = "name"
    }
    
    let id: String?
    let name: String?
    
}
