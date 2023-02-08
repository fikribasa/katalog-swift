//
//  FavouriteViewModel.swift
//  dicoding-katalog
//
//  Created by User on 10/3/21.
//

import Foundation

class FavoriteViewModel: ObservableObject {

    private var provider: GameProvider

    @Published var games: [Game] = []

    init(provider: GameProvider = GameProviderImpl()) {
        self.provider = provider
    }

    func getFavoriteGame() {
        self.provider.getAllFavourite { (games) in
            DispatchQueue.main.async {
                self.games = games
            }
        }
    }
}
