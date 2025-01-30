import Fluent

struct CreateTransaction: AsyncMigration {
    func prepare(on database: Database) async throws {
        let type = try await database.enum("type")
            .case("expense")
            .case("income")
            .create()

        try await database.schema("transactions")
            .id()
            .field("type", type, .required)
            .field("category", .dictionary, .required)
            .field("value", .double, .required)
            .field("note", .string, .required)
            .field("created_at", .date, .required)
            .create()
    }

    func revert(on database: Database) async throws {
        try await database.enum("type").delete()
        try await database.schema("transactions").delete()
    }
}
