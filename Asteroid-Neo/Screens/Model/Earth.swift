//
//  Earth.swift
//  Asteroid-Neo
//
//  Created by Admin on 06/09/2022.
//

import Foundation

// MARK: - Feed
struct Feed: Codable {
    let links: FeedWelcomeLinks?
    let elementCount: Int?
    let nearEarthObjects: [String: [FeedNearEarthObject]]?

    enum CodingKeys: String, CodingKey {
        case links
        case elementCount = "element_count"
        case nearEarthObjects = "near_earth_objects"
    }
}

struct reqFeed : Codable {
    let startDate: String?
    let endDate: String?
    let apiKey: String?
    enum CodingKeys: String, CodingKey {
        case startDate = "start_date"
        case endDate = "end_date"
        case apiKey = "api_key"
    }
}

// MARK: - FeedWelcomeLinks
struct FeedWelcomeLinks: Codable {
    let next, previous, linksSelf: String?

    enum CodingKeys: String, CodingKey {
        case next, previous
        case linksSelf = "self"
    }
}

// MARK: - FeedNearEarthObject
struct FeedNearEarthObject: Codable {
    let links: FeedNearEarthObjectLinks?
    let id, neoReferenceID, name: String?
    let nasaJplURL: String?
    let absoluteMagnitudeH: Double?
    let estimatedDiameter: FeedEstimatedDiameter?
    let isPotentiallyHazardousAsteroid: Bool?
    let closeApproachData: [FeedCloseApproachDatum]?
    let isSentryObject: Bool?

    enum CodingKeys: String, CodingKey {
        case links, id
        case neoReferenceID = "neo_reference_id"
        case name
        case nasaJplURL = "nasa_jpl_url"
        case absoluteMagnitudeH = "absolute_magnitude_h"
        case estimatedDiameter = "estimated_diameter"
        case isPotentiallyHazardousAsteroid = "is_potentially_hazardous_asteroid"
        case closeApproachData = "close_approach_data"
        case isSentryObject = "is_sentry_object"
    }
}

// MARK: - FeedCloseApproachDatum
struct FeedCloseApproachDatum: Codable {
    let closeApproachDate, closeApproachDateFull: String?
    let epochDateCloseApproach: Int?
    let relativeVelocity: FeedRelativeVelocity?
    let missDistance: FeedMissDistance?
    let orbitingBody: FeedOrbitingBody?

    enum CodingKeys: String, CodingKey {
        case closeApproachDate = "close_approach_date"
        case closeApproachDateFull = "close_approach_date_full"
        case epochDateCloseApproach = "epoch_date_close_approach"
        case relativeVelocity = "relative_velocity"
        case missDistance = "miss_distance"
        case orbitingBody = "orbiting_body"
    }
}

// MARK: - FeedMissDistance
struct FeedMissDistance: Codable {
    let astronomical, lunar, kilometers, miles: String?
}

enum FeedOrbitingBody: String, Codable {
    case earth = "Earth"
}

// MARK: - FeedRelativeVelocity
struct FeedRelativeVelocity: Codable {
    let kilometersPerSecond, kilometersPerHour, milesPerHour: String?

    enum CodingKeys: String, CodingKey {
        case kilometersPerSecond = "kilometers_per_second"
        case kilometersPerHour = "kilometers_per_hour"
        case milesPerHour = "miles_per_hour"
    }
}

// MARK: - FeedEstimatedDiameter
struct FeedEstimatedDiameter: Codable {
    let kilometers, meters, miles, feet: FeedFeet?
}

// MARK: - FeedFeet
struct FeedFeet: Codable {
    let estimatedDiameterMin, estimatedDiameterMax: Double?

    enum CodingKeys: String, CodingKey {
        case estimatedDiameterMin = "estimated_diameter_min"
        case estimatedDiameterMax = "estimated_diameter_max"
    }
}

// MARK: - FeedNearEarthObjectLinks
struct FeedNearEarthObjectLinks: Codable {
    let linksSelf: String?

    enum CodingKeys: String, CodingKey {
        case linksSelf = "self"
    }
}

struct chartValue {
    var value: Double
}
