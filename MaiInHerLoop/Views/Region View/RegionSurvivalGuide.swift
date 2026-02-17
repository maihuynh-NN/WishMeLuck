//
//  RegionSurvivalGuide.swift
//  MaiInHerLoop
//
//  Created by Huynh Ngoc Nhat Mai on 17/2/26.
//
import Foundation

// MARK: - Survival Guide Data
// All string content has been moved to Localizable.strings (en/vi)
// Keys follow the pattern: region.{regionKey}.sections.{1-4}.{title|content|subtitle}

struct SurvivalSection {
    let titleKey: String
    let contentKey: String
    let subtitleKey: String
}

struct RegionSurvivalGuide {
    let riskBriefingKey: String
    let survivalSections: [SurvivalSection]

    static let northGuide = RegionSurvivalGuide(
        riskBriefingKey: "region.north.riskBriefing",
        survivalSections: (1...4).map { i in
            SurvivalSection(
                titleKey:    "region.north.sections.\(i).title",
                contentKey:  "region.north.sections.\(i).content",
                subtitleKey: "region.north.sections.\(i).subtitle"
            )
        }
    )

    static let southGuide = RegionSurvivalGuide(
        riskBriefingKey: "region.south.riskBriefing",
        survivalSections: (1...4).map { i in
            SurvivalSection(
                titleKey:    "region.south.sections.\(i).title",
                contentKey:  "region.south.sections.\(i).content",
                subtitleKey: "region.south.sections.\(i).subtitle"
            )
        }
    )

    static let centralGuide = RegionSurvivalGuide(
        riskBriefingKey: "region.central.riskBriefing",
        survivalSections: (1...4).map { i in
            SurvivalSection(
                titleKey:    "region.central.sections.\(i).title",
                contentKey:  "region.central.sections.\(i).content",
                subtitleKey: "region.central.sections.\(i).subtitle"
            )
        }
    )
}
