import Vapor

@main
struct SwiftCLI {
    static func main() async throws {
        let app = try await Application.make(.detect())

        app.get("health") { req in
            var health: HealthData = HealthData.new()
            health.vms = [
                VirtualMachine(provider: .AWS),
                VirtualMachine.new(provider: .GCP),
            ]
            return health
        }

        app.get("greet") { req in
            let name = req.query[String.self, at: "name"] ?? "World"
            return "Hello, \(name)!"
        }

        try await app.execute()
    }
}