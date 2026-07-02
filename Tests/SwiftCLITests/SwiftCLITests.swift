import Testing
@testable import SwiftCLI

@Suite("[DATABASE] - Perform tests for the database...") struct DatabaseTests {
    @Test func testDatabaseConnection() async throws {
        print("Testing database connection...")
    }

    @Test func testCheckDatabaseSchema() async throws {
        print("Checking database schema...")
    }
}
