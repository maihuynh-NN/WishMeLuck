import Foundation

enum AppScreen: Hashable {
    case languageSelection
    case story
    case regionSelection
    case scenarioList(region: String)
    case game(scenario: Scenario)
    case diary
}
