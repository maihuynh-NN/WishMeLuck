//
//  Archetype.swift
//  MaiInHerLoop
//
//  Created by Mai Huynh Ngoc Nhat on 6/2/26.
//

import Foundation

struct Archetype: Codable, Identifiable {
    let id: String

    // Object asset name (xcassets)
    let objectImageName: String

    // Teaser — 2–3 words under the image
    let teaserEN: String
    let teaserVI: String

    // Mirror sentence — 1 line, oddly specific
    let mirrorEN: String
    let mirrorVI: String

    // Object explanation — local cultural layer
    let objectExplanationEN: String
    let objectExplanationVI: String

    // Trade-off — 1 honest sentence
    let tradeoffEN: String
    let tradeoffVI: String

    // Kept for DiaryListView display
    let nameEN: String
    let nameVI: String
    let imageName: String
}
