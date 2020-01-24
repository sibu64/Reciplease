// This file was generated from JSON Schema using quicktype, do not modify it directly.
// To parse the JSON, add this file to your project and do:
//
//   let welcome = try Welcome(json)

import Foundation

// MARK: - Welcome(response)
struct Welcome: Codable {
    let q: String
    let from: Int
    let to: Int
    let more: Bool
    let count: Int
    let hits: [Hit]
}

// MARK: Welcome convenience initializers and mutators

extension Welcome {
    init(data: Data) throws {
        self = try newJSONDecoder().decode(Welcome.self, from: data)
    }

    init(_ json: String, using encoding: String.Encoding = .utf8) throws {
        guard let data = json.data(using: encoding) else {
            throw NSError(domain: "JSONDecoding", code: 0, userInfo: nil)
        }
        try self.init(data: data)
    }

    init(fromURL url: URL) throws {
        try self.init(data: try Data(contentsOf: url))
    }

    func with(
        q: String? = nil,
        from: Int? = nil,
        to: Int? = nil,
        more: Bool? = nil,
        count: Int? = nil,
        hits: [Hit]? = nil
    ) -> Welcome {
        return Welcome(
            q: q ?? self.q,
            from: from ?? self.from,
            to: to ?? self.to,
            more: more ?? self.more,
            count: count ?? self.count,
            hits: hits ?? self.hits
        )
    }

    func jsonData() throws -> Data {
        return try newJSONEncoder().encode(self)
    }

    func jsonString(encoding: String.Encoding = .utf8) throws -> String? {
        return String(data: try self.jsonData(), encoding: encoding)
    }
}

// MARK: - Hit
struct Hit: Codable {
    var recipe: Recipe
    let bookmarked, bought: Bool
}

// MARK: Hit convenience initializers and mutators

extension Hit {
    init(data: Data) throws {
        self = try newJSONDecoder().decode(Hit.self, from: data)
    }

    init(_ json: String, using encoding: String.Encoding = .utf8) throws {
        guard let data = json.data(using: encoding) else {
            throw NSError(domain: "JSONDecoding", code: 0, userInfo: nil)
        }
        try self.init(data: data)
    }

    init(fromURL url: URL) throws {
        try self.init(data: try Data(contentsOf: url))
    }

    func with(
        recipe: Recipe? = nil,
        bookmarked: Bool? = nil,
        bought: Bool? = nil
    ) -> Hit {
        return Hit(
            recipe: recipe ?? self.recipe,
            bookmarked: bookmarked ?? self.bookmarked,
            bought: bought ?? self.bought
        )
    }

    func jsonData() throws -> Data {
        return try newJSONEncoder().encode(self)
    }

    func jsonString(encoding: String.Encoding = .utf8) throws -> String? {
        return String(data: try self.jsonData(), encoding: encoding)
    }
}

// MARK: - Recipe
struct Recipe: Codable, Equatable {
    let uri: String
    var label: String
    let image: String
    let url: String
    let yield: Int
    let ingredientLines: [String]
    let ingredients: [Ingredient]?
    let totalTime: Double
}

// MARK: Recipe convenience initializers and mutators

extension Recipe {
    init(data: Data) throws {
        self = try newJSONDecoder().decode(Recipe.self, from: data)
    }
    
    init(with favoriteRecipe: FavoriteRecipe) {
        self.uri = ""
        self.label = favoriteRecipe.name ?? ""
        self.image = favoriteRecipe.imageUrlString ?? ""
        self.url = favoriteRecipe.identifier ?? ""
        self.yield = 0
        self.ingredientLines = [""]
        self.totalTime = favoriteRecipe.totalTime
        
        let names = favoriteRecipe.ingredients?.components(separatedBy: ", ")
        let ingredients = names?.map {
            Ingredient(text: "", quantity: 0, measure: nil, food: $0, weight: 0)
        }
        self.ingredients = ingredients
    }

    init(_ json: String, using encoding: String.Encoding = .utf8) throws {
        guard let data = json.data(using: encoding) else {
            throw NSError(domain: "JSONDecoding", code: 0, userInfo: nil)
        }
        try self.init(data: data)
    }

    init(fromURL url: URL) throws {
        try self.init(data: try Data(contentsOf: url))
    }

    func with(
        uri: String? = nil,
        label: String? = nil,
        image: String? = nil,
        url: String? = nil,
        yield: Int? = nil,
        ingredientLines: [String]? = nil,
        ingredients: [Ingredient]? = nil,
        totalTime: Double? = nil
    ) -> Recipe {
        return Recipe(
            uri: uri ?? self.uri,
            label: label ?? self.label,
            image: image ?? self.image,
            url: url ?? self.url,
            yield: yield ?? self.yield,
            ingredientLines: ingredientLines ?? self.ingredientLines,
            ingredients: ingredients ?? self.ingredients,
            totalTime: totalTime ?? self.totalTime
        )
    }

    func jsonData() throws -> Data {
        return try newJSONEncoder().encode(self)
    }

    func jsonString(encoding: String.Encoding = .utf8) throws -> String? {
        return String(data: try self.jsonData(), encoding: encoding)
    }
}



// MARK: - Ingredient
struct Ingredient: Codable, Equatable {
    let text: String
    let quantity: Double
    let measure: String?
    let food: String
    let weight: Double
}

// MARK: Ingredient convenience initializers and mutators

extension Ingredient {
    init(data: Data) throws {
        self = try newJSONDecoder().decode(Ingredient.self, from: data)
    }

    init(_ json: String, using encoding: String.Encoding = .utf8) throws {
        guard let data = json.data(using: encoding) else {
            throw NSError(domain: "JSONDecoding", code: 0, userInfo: nil)
        }
        try self.init(data: data)
    }

    init(fromURL url: URL) throws {
        try self.init(data: try Data(contentsOf: url))
    }

    func with(
        text: String? = nil,
        quantity: Double? = nil,
        measure: String?? = nil,
        food: String? = nil,
        weight: Double? = nil
    ) -> Ingredient {
        return Ingredient(
            text: text ?? self.text,
            quantity: quantity ?? self.quantity,
            measure: measure ?? self.measure,
            food: food ?? self.food,
            weight: weight ?? self.weight
        )
    }

    func jsonData() throws -> Data {
        return try newJSONEncoder().encode(self)
    }

    func jsonString(encoding: String.Encoding = .utf8) throws -> String? {
        return String(data: try self.jsonData(), encoding: encoding)
    }
}

// MARK: - Helper functions for creating encoders and decoders

func newJSONDecoder() -> JSONDecoder {
    let decoder = JSONDecoder()
    if #available(iOS 10.0, OSX 10.12, tvOS 10.0, watchOS 3.0, *) {
        decoder.dateDecodingStrategy = .iso8601
    }
    return decoder
}

func newJSONEncoder() -> JSONEncoder {
    let encoder = JSONEncoder()
    if #available(iOS 10.0, OSX 10.12, tvOS 10.0, watchOS 3.0, *) {
        encoder.dateEncodingStrategy = .iso8601
    }
    return encoder
}

