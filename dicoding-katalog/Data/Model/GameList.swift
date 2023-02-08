//
//  GameList.swift
//  dicoding-katalog
//
//  Created by User on 8/29/21.
//

struct GameList: Codable {
    var count: Int
    var next: String?
    var previous: String?
    var results: [Game]?
}
