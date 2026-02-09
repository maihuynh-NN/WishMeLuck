//
//  NavigationPath.swift
//  MaiInHerLoop
//
//  Created by Mai Huynh Ngoc Nhat on 9/2/26.
//

import Foundation

enum AppScreen: Hashable {
    case languageSelection
    case story
    case regionSelection
    case scenarioList(region: String)
    case game(scenario: Scenario)
    case diary
}
