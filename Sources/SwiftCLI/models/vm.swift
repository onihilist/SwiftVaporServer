import Vapor

enum VMStatus: String, Codable {
    case RUNNING
    case STOPPED
    case BOOTING
    case SHUTTING_DOWN
    case SUSPENDED
    case TERMINATED
    case CONFIGURING
    case MAINTENANCE
    case ERROR
    case UNKNOWN
}

class CloudResource: Content {
    var id: String
    var provider: String

    required init(provider: CloudProvider) {
        if type(of: self) == CloudResource.self {
            fatalError("CloudResource is abstract and cannot be instantiated directly")
        }
        self.id = UUID().uuidString
        self.provider = provider.rawValue
    }
}

class VirtualMachine: CloudResource {
    var name: String
    var health: String
    var status: String
    var latency: Float32
    var equipment: [String]?
    var cpu_usage: Float32
    var mem_usage: Float32
    var disk_usage: Float32
    var network_usage: Float32
    var uptime: Int64
    var last_boot_time: Date?
    var last_shutdown_time: Date?

    required init(provider: CloudProvider) {
        let prefix: String
        switch provider {
        case .AWS: prefix = "aws"
        case .GCP: prefix = "gcp"
        case .AZURE: prefix = "azure"
        case .DIGITAL_OCEAN: prefix = "do"
        }

        self.name = "\(prefix)-VM-\(Int.random(in: 1000...9999))"
        self.health = "healthy"
        self.status = VMStatus.unknown.rawValue
        self.latency = 0.0
        self.equipment = nil
        self.cpu_usage = 0.0
        self.mem_usage = 0.0
        self.disk_usage = 0.0
        self.network_usage = 0.0
        self.uptime = 0
        self.last_boot_time = nil
        self.last_shutdown_time = nil

        super.init(provider: provider)
    }

    static func new(provider: CloudProvider) -> VirtualMachine {
        return VirtualMachine(provider: provider)
    }
}