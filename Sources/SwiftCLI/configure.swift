import Vapor
import MongoKitten

public func configure(_ app: Application) async throws {
    
    app.middleware.use(FileMiddleware(publicDirectory: app.directory.publicDirectory))
    
    let mongoURI = Environment.get("MONGO_URI") ?? "mongodb://localhost:27017/vapor"
    
    do {
        let db = try await MongoDatabase.connect(to: mongoURI)
        app.mongoDB = db
        app.logger.info("Connexion MongoDB établie sur \(mongoURI)")
    } catch {
        app.logger.error("Échec de connexion à MongoDB: \(error)")
        throw error
    }
    
    app.http.server.configuration.hostname = Environment.get("HOST") ?? "127.0.0.1"
    app.http.server.configuration.port = Int(Environment.get("PORT") ?? "8080") ?? 8080
    
    let encoder = JSONEncoder()
    encoder.dateEncodingStrategy = .iso8601
    ContentConfiguration.global.use(encoder: encoder, for: .json)
    
    let decoder = JSONDecoder()
    decoder.dateDecodingStrategy = .iso8601
    ContentConfiguration.global.use(decoder: decoder, for: .json)
}