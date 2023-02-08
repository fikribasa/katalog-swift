//
//  GameProvider.swift
//  dicoding-katalog
//
//  Created by User on 10/3/21.
//

import Foundation
import CoreData

typealias GetAllFavoriteCompletion = (_ game: [Game]) -> Void
typealias AddFavoriteCompletion = () -> Void
typealias MaxIdCompletion = (_ maxId: Int) -> Void
typealias FindFavoriteCompletion = (_ isExist: Bool) -> Void
typealias RemoveFavoriteCompletion = () -> Void

protocol GameProvider {
    func getAllFavourite(completion: @escaping GetAllFavoriteCompletion)
    func addFavourite(game: Game, completion: @escaping AddFavoriteCompletion)
    func findFavourite(gameID: Int, completion: @escaping FindFavoriteCompletion)
    func removeFavourite(gameID: Int, completion: @escaping RemoveFavoriteCompletion)
}

class GameProviderImpl {

    private static let entity: String = "FavouriteGame"
    private enum Attribute: String {
        case id
        case name
        case image
        case released
        case playtime
        case rating
        case metascore
    }

    lazy var persistentContainer: NSPersistentContainer = {
        let container = NSPersistentContainer(name: "GameData")

        container.loadPersistentStores { (_, error) in
            guard error == nil else {
                fatalError("Unresolved error \(error!)")
            }
        }

        container.viewContext.automaticallyMergesChangesFromParent = false
        container.viewContext.mergePolicy = NSMergeByPropertyObjectTrumpMergePolicy
        container.viewContext.shouldDeleteInaccessibleFaults = true
        container.viewContext.undoManager = nil

        return container
    }()

    private func newTaskContext() -> NSManagedObjectContext {
        let taskContext = self.persistentContainer.newBackgroundContext()
        taskContext.undoManager = nil
        taskContext.mergePolicy = NSMergeByPropertyObjectTrumpMergePolicy
        return taskContext
    }
}

extension GameProviderImpl: GameProvider {

    func getAllFavourite(completion: @escaping GetAllFavoriteCompletion) {
        let taskContext = self.newTaskContext()
        taskContext.perform {
            let fetchRequest = NSFetchRequest<NSManagedObject>(entityName: GameProviderImpl.entity)
            do {
                let results = try taskContext.fetch(fetchRequest)
                var games: [Game] = []
                for result in results {
                    let game: Game = Game(id: result.value(forKeyPath: Attribute.id.rawValue) as? Int,
                                          name: result.value(forKeyPath: Attribute.name.rawValue) as? String,
                                          description: nil, rating: result.value(forKeyPath: Attribute.rating.rawValue) as? Float,
                                          backgroundImage: result.value(forKeyPath: Attribute.image.rawValue) as? String,
                                          released: result.value(forKeyPath: Attribute.released.rawValue) as? Date,
                                          playtime: result.value(forKeyPath: Attribute.playtime.rawValue) as? Int,
                                          genres: nil,
                                          metaScore: result.value(forKeyPath: Attribute.metascore.rawValue) as? Int)
                    games.append(game)
                }
                completion(games)
            } catch let error as NSError {
                print("Could no fetch. \(error), \(error.userInfo)")
            }
        }
    }

    func addFavourite(game: Game, completion: @escaping AddFavoriteCompletion) {
        let taskContext = self.newTaskContext()
        taskContext.performAndWait {
            if let entity = NSEntityDescription.entity(forEntityName: GameProviderImpl.entity, in: taskContext) {
                let data = NSManagedObject(entity: entity, insertInto: taskContext)
                    data.setValue(game.id, forKey: Attribute.id.rawValue)
                    data.setValue(game.backgroundImage, forKey: Attribute.image.rawValue)
                    data.setValue(game.released, forKey: Attribute.released.rawValue)
                    data.setValue(game.name, forKey: Attribute.name.rawValue)
                    data.setValue(game.playtime, forKey: Attribute.playtime.rawValue)
                    data.setValue(game.rating, forKey: Attribute.rating.rawValue)
                    data.setValue(game.metaScore, forKey: Attribute.metascore.rawValue)
                    do {
                        try taskContext.save()
                        completion()
                    } catch let error as NSError {
                        print("Could not save. \(error), \(error.userInfo)")
                    }
            }
        }
    }

    func findFavourite(gameID: Int, completion: @escaping FindFavoriteCompletion) {
        let taskContext = self.newTaskContext()
        taskContext.perform {
            let fetchRequest = NSFetchRequest<NSManagedObject>(entityName: GameProviderImpl.entity)
            fetchRequest.fetchLimit = 1
            fetchRequest.predicate = NSPredicate(format: "\(Attribute.id.rawValue) == \(gameID)")
            do {
                if let _ = try taskContext.fetch(fetchRequest).first {
                    completion(true)
                } else {
                    completion(false)
                }
            } catch let error as NSError {
                print("Could not fecth. \(error), \(error.userInfo)")
            }
        }
    }

    func removeFavourite(gameID: Int, completion: @escaping RemoveFavoriteCompletion) {
        let taskContext = self.newTaskContext()
        taskContext.perform {
            let fetchRequest = NSFetchRequest<NSFetchRequestResult>(entityName: GameProviderImpl.entity)
            fetchRequest.predicate = NSPredicate(format: "\(Attribute.id.rawValue) == \(gameID)")

            let batchDeleteRequest = NSBatchDeleteRequest(fetchRequest: fetchRequest)
            batchDeleteRequest.resultType = .resultTypeCount
            if let batchDeleteResult = try? taskContext.execute(batchDeleteRequest) as? NSBatchDeleteResult, batchDeleteResult.result != nil {
                completion()
            }
        }
    }
}
