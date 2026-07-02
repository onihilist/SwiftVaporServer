import Vapor

enum VMStatus: String, Codable, Sendable {
    case RUNNING, STOPPED, BOOTING, SHUTTING_DOWN, SUSPENDED,
         TERMINATED, CONFIGURING, MAINTENANCE, ERROR, UNKNOWN
}

struct ResourceMetadata: Codable, Sendable {
    var id: String
    var provider: String

    init(provider: CloudProvider) {
        self.id = UUID().uuidString
        self.provider = provider.rawValue
    }
}

struct VirtualMachine: Content {
    var resource: ResourceMetadata
    var name: String
    var health: String
    var status: String
    var address: String
    var latency: Float32
    var equipment: [String]?
    var cpu_usage: Float32
    var mem_usage: Float32
    var disk_usage: Float32
    var network_usage: Float32
    var uptime: Int64
    var last_boot_time: Date?
    var last_shutdown_time: Date?

    init(provider: CloudProvider) {
        let prefix: String
        switch provider {
        case .AWS: prefix = "aws"
        case .GCP: prefix = "gcp"
        case .AZURE: prefix = "azure"
        case .DIGITAL_OCEAN: prefix = "do"
        }

        self.resource = ResourceMetadata(provider: provider)
        self.name = "\(prefix)-VM-\(Int.random(in: 1000...9999))"
        self.health = "healthy"
        self.status = VMStatus.UNKNOWN.rawValue
        self.address = "\(prefix)-\(Int.random(in: 1000...9999)).cloudprovider.com"
        self.latency = 0.0
        self.equipment = nil
        self.cpu_usage = 0.0
        self.mem_usage = 0.0
        self.disk_usage = 0.0
        self.network_usage = 0.0
        self.uptime = 0
        self.last_boot_time = nil
        self.last_shutdown_time = nil
    }

    static func new(provider: CloudProvider) -> VirtualMachine {
        VirtualMachine(provider: provider)
    }
}