import Vapor

struct HealthData: Content {
    let ts: Date
    let database: Bool
    let api: Bool
    let latency: Float32

    static func new() -> HealthData {
        return HealthData{
            Date.new(),
            false,
            false,
            0.0
        }
    }
}