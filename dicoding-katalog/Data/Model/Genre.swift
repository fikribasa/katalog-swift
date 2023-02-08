//
//  Genre.swift
//  dicoding-katalog
//
//  Created by User on 8/29/21.
//

struct Genre: Codable, Identifiable {
    var id: Int?
    var name: String?
    var slug: String?
    var gamesCount: Int?
    var imageBackground: String?

    enum CodingKeys: String, CodingKey {
        case id
        case name
        case slug
        case gamesCount = "games_count"
        case imageBackground = "image_background"
    }

    init(id: Int, name: String, slug: String, gamesCount: Int, imageBackground: String) {
        self.id = id
        self.name = name
        self.slug = slug
        self.gamesCount = gamesCount
        self.imageBackground = imageBackground
    }
}
