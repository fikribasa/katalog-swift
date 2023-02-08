//
//  HomeVoewModel.swift
//  dicoding-katalog
//
//  Created by User on 8/29/21.
//

import Foundation

class HomeViewModel: ObservableObject {
    private let service: GameService

    @Published var isLoading: Bool = true
    @Published var games: [Game] = []
    @Published var query: String = "" {
        didSet {
            self.discover()
        }
    }
    init(service: GameService = GameServiceImpl()) {
        self.service = service
    }

    func discover() {
        self.isLoading = true
        self.service.discoverGame(query: self.query) { (result) in
            var gameResult: [Game] = []
            switch result {
            case .success(let games):
                gameResult = games
            case .failure(let error):
                print(error.localizedDescription)
            }

            DispatchQueue.main.async {
                self.games = gameResult
                self.isLoading = false
            }
        }
    }
}
