//
//  DiaryHelpers.swift
//  MaiInHerLoop
//
//  Created by Mai Huynh Ngoc Nhat on 25/2/26.
//
import Foundation

enum DiaryHelpers {

    /// Maps scenarioID → tile asset name.
    /// "south_easy_3" → "tile3", "north_easy_1" → "tile1", etc.
    static func tileName(for scenarioID: String) -> String {
        let parts = scenarioID.components(separatedBy: "_easy_")
        guard parts.count == 2,
              let num = Int(parts[1]),
              (1...5).contains(num)
        else { return "tile1" }
        return "tile\(num)"
    }

    /// Extracts region string from scenarioID.
    /// "south_easy_1" → "south"
    static func region(for scenarioID: String) -> String {
        scenarioID.components(separatedBy: "_").first ?? "south"
    }

    /// Localised region display name.
    static func regionLabel(_ region: String, language: String) -> String {
        switch region {
        case "north":   return language == "vi" ? "Miền Bắc"  : "North"
        case "central": return language == "vi" ? "Miền Trung" : "Central"
        case "south":   return language == "vi" ? "Miền Nam"   : "South"
        default:        return region.capitalized
        }
    }

    /// Formatted date string for diary header.
    static func formattedDate(_ date: Date, language: String) -> String {
        let formatter = DateFormatter()
        formatter.locale = Locale(identifier: language == "vi" ? "vi_VN" : "en_US")
        formatter.dateStyle = .long
        return formatter.string(from: date)
    }
}
