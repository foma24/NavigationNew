import Foundation

struct PlanetModel: Codable {
    let name: String
    let rotationPeriod: String
    let orbitalPeriod: String
    let diameter: String
    let climate: String
    let gravity: String
    let terrain: String
    let surfaceWater: String
    let population: String
    let residentsURL: [URL]?
    let films: [URL]?
    let created: String
    let edited: String

    let url: URL?

    enum CodingKeys: String, CodingKey {
        case name, diameter, climate, gravity, terrain, population, films, created, edited, url
        case rotationPeriod = "rotation_period"
        case orbitalPeriod = "orbital_period"
        case surfaceWater = "surface_water"
        case residentsURL = "residents"
    }
}

struct Residents: Codable {
    let name: String
}
