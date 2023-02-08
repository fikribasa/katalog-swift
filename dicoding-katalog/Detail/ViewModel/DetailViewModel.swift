//
//  DetailViewScreen.swift
//  dicoding-katalog
//
//  Created by User on 8/29/21.
//

import Foundation

class DetailViewModel: ObservableObject {
    private let service: GameService
    private let gameProvider: GameProvider

    @Published var isFavorite: Bool = false
    @Published var isLoading: Bool = true
    @Published var game: Game?

    init(service: GameService = GameServiceImpl(), provider: GameProvider = GameProviderImpl()) {
        self.service = service
        self.gameProvider = provider
    }

    func getDetailGame(gameID: Int) {
        self.isLoading = true
        self.service.getDetail(gameID: gameID) { [weak self] (result) in
            guard let self = self else { return }
            var gameResult: Game?
            switch result {
            case .success(let game):
                gameResult = game
            case .failure(let error):
                print(error.localizedDescription)
            }

            DispatchQueue.main.async {
                self.game = gameResult
                self.isLoading = false
            }

            self.isFavouriteGame(gameID: gameResult?.id ?? 0)
        }
    }

    func isFavouriteGame(gameID: Int) {
        self.gameProvider.findFavourite(gameID: gameID) { (isExist) in
            DispatchQueue.main.async {
                self.isFavorite = isExist
            }
        }
    }

    func addToFavoriteList(game: Game) {
        self.gameProvider.addFavourite(game: game) {
            DispatchQueue.main.async {
                self.isFavorite = true
            }
        }
    }

    func removeFavorite(gameID: Int) {
        self.gameProvider.removeFavourite(gameID: gameID) {
            DispatchQueue.main.async {
                self.isFavorite = false
            }
        }
    }
}
