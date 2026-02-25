//
//  Archetype.swift
//  MaiInHerLoop
//
//  Created by Mai Huynh Ngoc Nhat on 6/2/26.
//

import Foundation

struct Archetype: Codable, Identifiable {
    let id: String

    // Object image asset name (in xcassets)
    let objectImageName: String

    // Object teaser — 2–3 words shown under the image before explanation
    let teaserEN: String
    let teaserVI: String

    // Mirror sentence — 1 oddly specific line that names the tendency
    let mirrorEN: String
    let mirrorVI: String

    // Object explanation — 1–2 sentences, local cultural layer
    let objectExplanationEN: String
    let objectExplanationVI: String

    // Trade-off — 1 honest sentence, no moralizing
    let tradeoffEN: String
    let tradeoffVI: String

    // Legacy fields kept for DiaryListView and backward compat
    let nameEN: String
    let nameVI: String
    let imageName: String
}
