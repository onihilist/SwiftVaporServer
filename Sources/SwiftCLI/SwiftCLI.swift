import Vapor

@main
struct SwiftCLI {
    static func main() async throws {
        let app = try await Application.make(.detect())

        app.get("health") { req in
            let health: HealthData = HealthData.new()
            print()
        }

        app.get("greet") { req in
            let name = req.query[String.self, at: "name"] ?? "World"
            return "Hello, \(name)!"
        }

        try await app.execute()
    }
}