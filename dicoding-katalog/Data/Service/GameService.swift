//
//  GameService.swift
//  dicoding-katalog
//
//  Created by User on 8/29/21.
//

import Foundation

typealias GameResultCompletion = (Result<[Game], NetworkError>) -> Void
typealias GameDetailResultCompletion = (Result<Game, NetworkError>) -> Void

protocol GameService {
    func discoverGame(query: String?, completion: @escaping GameResultCompletion)
    func getDetail(gameID: Int, completion: @escaping GameDetailResultCompletion)
}

class GameServiceImpl: GameService {
    private let baseUrl: String = "https://api.rawg.io/api/"
    private let urlSession: URLSession = URLSession.shared
    private var keyToken: String {
      get {
        // 1
        guard let filePath = Bundle.main.path(forResource: "Game-Info", ofType: "plist") else {
          fatalError("Couldn't find file 'Game-Info.plist'.")
        }
        // 2
        let plist = NSDictionary(contentsOfFile: filePath)
        guard let value = plist?.object(forKey: "API_KEY") as? String else {
          fatalError("Couldn't find key 'API_KEY' in 'Game-Info.plist'.")
        }
        return value
      }
    }
    func discoverGame(query: String?, completion: @escaping GameResultCompletion) {
        var components: URLComponents = URLComponents(string: self.baseUrl + "games")!
        components.queryItems = [URLQueryItem(name: "key", value: keyToken)]
        if let searchQuery = query, !searchQuery.isEmpty {
            components.queryItems = [
                URLQueryItem(name: "key", value: keyToken),
                URLQueryItem(name: "search", value: query)
            ]
        }
        let request = URLRequest(url: components.url!)
        self.urlSession.dataTask(with: request) { (data, _, error) in
            if error != nil {
                completion(.failure(.networkError))
            } else {
                do {
                    let result = try JSONDecoder().decode(GameList.self, from: data!)
                    if let gameList = result.results {
                        completion(.success(gameList))
                    } else {
                        completion(.failure(.notFound))
                    }
                } catch let error {
                    print(error)
                    completion(.failure(.networkError))
                }
            }
        }.resume()
    }

    func getDetail(gameID: Int, completion: @escaping GameDetailResultCompletion) {
        var components: URLComponents = URLComponents(string: self.baseUrl + "games/\(gameID)")!
        components.queryItems = [URLQueryItem(name: "key", value: keyToken)]
        let request = URLRequest(url: components.url!)
        print(components.url!)
        self.urlSession.dataTask(with: request) { (data, _, error) in
            if error != nil {
                completion(.failure(.networkError))
            } else {
                do {
                    let result = try JSONDecoder().decode(Game.self, from: data!)
                    completion(.success(result))
                } catch let error {
                    print(error)
                    completion(.failure(.networkError))
                }
            }
        }.resume()
    }
}
