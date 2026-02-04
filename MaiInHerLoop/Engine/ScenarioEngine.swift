//
//  ScenarioEngine.swift
//  MaiInHerLoop
//
//  Created by Mai Huynh Ngoc Nhat on 4/2/26.
//
import Foundation

final class ScenarioEngine: ObservableObject {
    @Published var currentQuestion: Question?
    @Published var traitCounts: [String: Int] = [:]
    @Published var isComplete: Bool = false

    private let scenario: Scenario
    private let questionMap: [String: Question]

    init(scenario: Scenario) {
        self.scenario = scenario
        self.questionMap = Dictionary(
            uniqueKeysWithValues: scenario.questions.map { ($0.id, $0) }
        )
        self.currentQuestion = questionMap[scenario.startQuestionID]
    }

    func selectOption(_ option: Option) {
        traitCounts[option.traitTag, default: 0] += 1

        if let nextID = option.nextQuestionID,
           let nextQuestion = questionMap[nextID] {
            currentQuestion = nextQuestion
        } else {
            currentQuestion = nil
            isComplete = true
        }
    }

    func dominantTrait() -> String {
        traitCounts.max(by: { $0.value < $1.value })?.key ?? ""
    }
}
