import Vapor

struct VirtualMachine: Content {
    var id: String
    var name: String
    var provider: String
    var health: String
    var status: String
    var latency: Float32
    var equipment: [String]?

    static func new() -> VirtualMachine {
        return VirtualMachine(
            id: UUID().uuidString,
            name: "VM-\(Int.random(in: 1000...9999))",
            provider: "unknown",
            health: "healthy",
            status: VMStatus.unknown.rawValue,
            latency: 0.0,
            equipment: nil
        )
    }
}

enum VMStatus: String, Codable {
    case running
    case stopped
    case booting
    case shuttingDown
    case suspended
    case terminated
    case configuring
    case error
    case unknown
}