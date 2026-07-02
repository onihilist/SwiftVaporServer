import Vapor
import MongoKitten

@main
struct SwiftCLI {
    static func main() async throws {
        let app = try await Application.make(.detect())
        
        try await configure(app)

        let usersCollection = app.mongoDB["users"]

        app.get("health") { req in
            var health: HealthData = HealthData.new()
            health.vms = [
                VirtualMachine(provider: .AWS),
                VirtualMachine.new(provider: .GCP),
            ]
            return health
        }

        app.get("users") { req async throws -> [User] in
            try await usersCollection.find().decode(User.self).drain()
        }

        app.post("users") { req async throws -> User in
            let user = try req.content.decode(User.self)
            try await usersCollection.insertEncoded(user)
            return user
        }

        app.get("users", ":id") { req async throws -> User in
            guard let id = req.parameters.get("id") else {
                throw Abort(.badRequest)
            }
            guard let user = try await usersCollection
                .findOne("_id" == id, as: User.self) else {
                throw Abort(.notFound)
            }
            return user
        }

        try await app.execute()
    }
}