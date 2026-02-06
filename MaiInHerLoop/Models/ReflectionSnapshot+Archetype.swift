//
//  ReflectionSnapshot+Archetype.swift
//  MaiInHerLoop
//
//  Created by Mai Huynh Ngoc Nhat on 6/2/26.
//
import Foundation

extension ReflectionSnapshot {
    static func from(archetype: Archetype) -> ReflectionSnapshot {
        ReflectionSnapshot(
            recognitionText: archetype.recognitionEN,
            bullets: archetype.bulletsEN,
            strength: archetype.strengthEN,
            blindSpot: archetype.blindSpotEN,
            direction: archetype.directionEN,
            archetypeID: archetype.id
        )
    }
}
