//
//  Archetype.swift
//  MaiInHerLoop
//
//  Created by Mai Huynh Ngoc Nhat on 6/2/26.
//

import Foundation

struct Archetype: Codable, Identifiable {
    let id: String
    
    // Core identity
    let nameEN: String
    let nameVI: String
    let definitionEN: String
    let definitionVI: String
    let imageName: String  
    
    // Recognition
    let recognitionEN: String
    let recognitionVI: String
    
    // Behavioral bullets
    let bulletsEN: [String]
    let bulletsVI: [String]
    
    // Reflection components
    let strengthEN: String
    let strengthVI: String
    let blindSpotEN: String
    let blindSpotVI: String
    let directionEN: String
    let directionVI: String
}
