//
//  DataExtension.swift
//  dicoding-katalog
//
//  Created by User on 8/29/21.
//

import Foundation

extension Game {
    static var defaultValue: Game {
        Game(id: 1, name: "GTA", description: "", rating: 8, backgroundImage: "",
             released: Date(), playtime: 80,
             genres: [Genre(id: 0, name: "Action", slug: "", gamesCount: 0, imageBackground: "")], metaScore: 10)
    }

    func getGenre() -> String {
        guard let genres = self.genres else { return "" }
        let genreNames: [String] = genres.map { $0.name ?? "" }

        return genreNames.joined(separator: ", ")
    }
}
