//
//  Game.swift
//  GamePrices_storyboard
//
//  Created by Egor Moroz on 21.08.24.
//

import Foundation

struct Game: Codable {
    let internalName, title, metacriticLink, dealID: String?
    let storeID, gameID, salePrice, normalPrice: String?
    let isOnSale, savings, metacriticScore: String?
    let steamRatingText: SteamRatingText?
    let steamRatingPercent, steamRatingCount, steamAppID: String?
    let releaseDate, lastChange: Int?
    let dealRating: String?
    let thumb: String?
}

enum SteamRatingText: String, Codable {
    case mixed = "Mixed"
    case mostlyPositive = "Mostly Positive"
    case overwhelminglyPositive = "Overwhelmingly Positive"
    case veryPositive = "Very Positive"
}

typealias Games = [Game]
