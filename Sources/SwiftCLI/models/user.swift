struct User: Content {
    let id: String
    var username: String
    var displayed_username: String
    var password: String
    var api_auth: String
    var auth: String
    var creation_date: Date
    var pfp_url: String

    static func new() -> HealthData {
        return HealthData(
            id:  UUID().uuidString,
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