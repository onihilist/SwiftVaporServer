import Foundation
import Vapor
import MongoKitten

struct User: Content {
    let _id: String
    var username: String?
    var displayed_username: String?
    var password: String?
    var api_auth: String?
    var auth: String?
    var creation_date: Date?
    var pfp_url: String?

    static func new() -> User {
        return User(
            _id: UUID().uuidString,
            username: nil,
            displayed_username: nil,
            password: nil,
            api_auth: nil,
            auth: nil,
            creation_date: Date(),
            pfp_url: nil
        )
    }
}