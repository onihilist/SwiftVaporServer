import Vapor
import Foundation

struct VmCtrlError: Error { let message: String }

func runVmctrl(_ args: [String]) async throws -> Data {
    try await withCheckedThrowingContinuation { continuation in
        let process = Process()
        process.executableURL = URL(fileURLWithPath: "/usr/local/bin/vmctrl")
        process.arguments = args

        let stdout = Pipe()
        let stderr = Pipe()
        process.standardOutput = stdout
        process.standardError = stderr

        process.terminationHandler = { proc in
            let outData = stdout.fileHandleForReading.readDataToEndOfFile()
            if proc.terminationStatus == 0 {
                continuation.resume(returning: outData)
            } else {
                let errData = stderr.fileHandleForReading.readDataToEndOfFile()
                let msg = String(data: errData, encoding: .utf8) ?? "unknown error"
                continuation.resume(throwing: VmCtrlError(message: msg))
            }
        }

        do {
            try process.run()
        } catch {
            continuation.resume(throwing: error)
        }
    }
}