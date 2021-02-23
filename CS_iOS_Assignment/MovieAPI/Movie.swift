// This file was generated from JSON Schema using quicktype, do not modify it directly.
// To parse the JSON, add this file to your project and do:
//
//   let movie = try? newJSONDecoder().decode(Movie.self, from: jsonData)

import Foundation

// MARK: - MoviesAPIResponse
struct MoviesAPIResponse: Codable {
    let dates: Dates?
    let page: Int?
    let results: [Movie]?
    let totalPages, totalResults: Int?
    
    enum CodingKeys: String, CodingKey {
        case dates, page, results
        case totalPages
        case totalResults
    }
}

// MARK: - Dates
struct Dates: Codable {
    let maximum, minimum: String?
}

// MARK: - Result - commented out extra fields to minimize decoding errors
struct Movie: Codable, Identifiable {
    //    let adult: Bool?
    //    let backdropPath: String?
    //let belongsToCollection: JSONNull?
    //    let budget: Int?
    let genres: [Genre]?
    //    let genreIDS: [Int]?
    //    let homepage: String?
    let id: Int
    //    let imdbID: String?
    //    let originalLanguage: String?
    //    let originalTitle: String?
    let overview: String?
    //    let popularity: Double?
    let posterPath: String?
    //    let productionCompanies: [ProductionCompany]?
    //    let productionCountries: [ProductionCountry]?
    let releaseDate: String?
    //    let revenue: Int?
    let runtime: Int?
    //    let spokenLanguages: [SpokenLanguage]?
    //    let status: String?
    //    let tagline: String?
    let title: String?
    //    let video: Bool?
    let voteAverage: Double?
    //    let voteCount: Int?
    
    var releaseDateString: String {
        get {
            guard (releaseDate != nil) else {
                return ""
            }
            if releaseDate == "" {
                return ""
            }
            
            let formatter = DateFormatter()
            formatter.dateFormat = "yyyy-MM-dd"
            let date = formatter.date(from: releaseDate ?? "")
            
            let dateFormatter = DateFormatter()
            dateFormatter.dateFormat = "MMMM d, yyyy"
            return dateFormatter.string(from: date!)
        }
    }
    
    var runtimeString: String {
        get {
            guard (runtime != nil) else {
                return ""
            }
            let formatter = DateComponentsFormatter()
            formatter.allowedUnits = [.hour, .minute, .second, .nanosecond]
            formatter.unitsStyle = DateComponentsFormatter.UnitsStyle.abbreviated
            guard let formattedString = formatter.string(from: TimeInterval( (runtime ?? 0) * 60)) else { return "" }
            return formattedString
        }
    }
    
    enum CodingKeys: String, CodingKey {
        //        case adult
        //        case backdropPath
        //case belongsToCollection
        //        case budget
        case genres
        //        case genreIDS
        //        case homepage
        case id
        //        case imdbID
        //        case originalLanguage
        //        case originalTitle
        case overview
        //        case popularity
        case posterPath
        //        case productionCompanies
        //        case productionCountries
        case releaseDate
        //        case revenue
        case runtime
        //        case spokenLanguages
        //        case status
        //        case tagline
        case title
        //        case video
        case voteAverage
        //        case voteCount
    }
}

// MARK: - Genre
struct Genre: Codable, Identifiable {
    let id: Int?
    let name: String?
}

// MARK: - ProductionCompany
struct ProductionCompany: Codable {
    let id: Int?
    let logoPath: String?
    let name, originCountry: String?
    
    enum CodingKeys: String, CodingKey {
        case id
        case logoPath
        case name
        case originCountry
    }
}

// MARK: - ProductionCountry
struct ProductionCountry: Codable {
    let iso3166_1, name: String?

    enum CodingKeys: String, CodingKey {
        case iso3166_1
        case name
    }
}

// MARK: - SpokenLanguage
struct SpokenLanguage: Codable {
    let englishName, iso639_1, name: String?

    enum CodingKeys: String, CodingKey {
        case englishName
        case iso639_1
        case name
    }
}

// MARK: - Encode/decode helpers
class JSONNull: Codable, Hashable {
    
    public static func == (lhs: JSONNull, rhs: JSONNull) -> Bool {
        return true
    }
    
    //    public var hashValue: Int {
    //        return 0
    //    }
    
    func hash(into hasher: inout Hasher) {
        hasher.combine(0)
    }
    
    public init() {}
    
    public required init(from decoder: Decoder) throws {
        let container = try decoder.singleValueContainer()
        if !container.decodeNil() {
            throw DecodingError.typeMismatch(JSONNull.self, DecodingError.Context(codingPath: decoder.codingPath, debugDescription: "Wrong type for JSONNull"))
        }
    }
    
    public func encode(to encoder: Encoder) throws {
        var container = encoder.singleValueContainer()
        try container.encodeNil()
    }
}
