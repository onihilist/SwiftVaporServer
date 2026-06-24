import Vapor

struct HealthData: Content {
    let ts: Date
    var database: Bool
    var api: Bool
    var api_latency: Float32
    var vms: [VirtualMachine]?

    static func new() -> HealthData {
        return HealthData(
            ts: Date(),
            database: false,
            api: false,
            api_latency: 0.0,
            vms: nil
        )
    }
}