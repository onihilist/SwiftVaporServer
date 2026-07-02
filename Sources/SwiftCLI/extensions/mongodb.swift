import Vapor
import MongoKitten

struct MongoDBStorageKey: StorageKey {
    typealias Value = MongoDatabase
}

extension Application {
    var mongoDB: MongoDatabase {
        get {
            guard let db = storage[MongoDBStorageKey.self] else {
                fatalError("MongoDB non configuré. Appelez configure() d'abord.")
            }
            return db
        }
        set {
            storage[MongoDBStorageKey.self] = newValue
        }
    }
}

extension Request {
    var mongoDB: MongoDatabase {
        application.mongoDB
    }
}