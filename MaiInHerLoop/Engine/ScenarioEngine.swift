//
//  ScenarioEngine.swift
//  MaiInHerLoop
//
//  Created by Mai Huynh Ngoc Nhat on 4/2/26.
//
import Foundation

@MainActor
final class ScenarioEngine: ObservableObject {

    // MARK: - Published state
    @Published var currentQuestion: Question?
    @Published var traitCounts: [String: Int] = [:]
    @Published var timeRemaining: Int = 0
    @Published var isComplete: Bool = false
    @Published var score: Int = 100
    @Published var isActive: Bool = false  
    
    // MARK: - Private
    let scenario: Scenario
    private let questionMap: [String: Question]
    private var timer: Timer?
    
    var scenarioID: String {
        scenario.id
    }
    
    var missionIndex: Int {
        let parts = scenario.id.split(separator: "_")
        if let last = parts.last, let number = Int(last) {
            return max(0, number - 1)
        }
        return 0
    }

    // MARK: - Init
    init(scenario: Scenario) {
        self.scenario = scenario
        self.questionMap = Dictionary(
            uniqueKeysWithValues: scenario.questions.map { ($0.id, $0) }
        )

        if let first = questionMap[scenario.startQuestionID] {
            currentQuestion = first
            timeRemaining = first.timer
            // DON'T start timer here
        }
    }
    
    // NEW: Start the game
    func start() {
        isActive = true
        startTimer()
    }

    // MARK: - Public actions

    func selectOption(_ option: Option) {
        stopTimer()

        traitCounts[option.traitTag, default: 0] += 1

        if let nextID = option.nextQuestionID,
           let nextQuestion = questionMap[nextID] {
            transition(to: nextQuestion)
        } else {
            completeScenario()
        }
    }

    func dominantTrait() -> String {
        traitCounts.max(by: { $0.value < $1.value })?.key ?? ""
    }

    // MARK: - Timer handling

    private func transition(to question: Question) {
        currentQuestion = question
        timeRemaining = question.timer
        if isActive {  // Only start timer if game is active
            startTimer()
        }
    }

    private func startTimer() {
        stopTimer()

        guard timeRemaining > 0, isActive else { return }  // Check isActive

        timer = Timer.scheduledTimer(
            withTimeInterval: 1,
            repeats: true
        ) { [weak self] _ in
            self?.tick()
        }
    }

    private func stopTimer() {
        timer?.invalidate()
        timer = nil
    }

    private func tick() {
        guard timeRemaining > 0 else { return }

        timeRemaining -= 1

        if timeRemaining == 0 {
            handleTimeout()
        }
    }

    // MARK: - Timeout rule (exact spec)

    private func handleTimeout() {
        stopTimer()

        score = max(0, score - 10)
        print("TIMEOUT: Score penalty applied. New score: \(score)")

        // Move forward WITHOUT selecting an option
        advanceWithoutSelection()
    }

    private func advanceWithoutSelection() {
        guard let current = currentQuestion else { return }

        traitCounts["information_first", default: 0] += 1
        print("⏱️ TIMEOUT: Assigned default trait 'information_first'")

        // no branching on timeout; assume linear flow
        if let index = scenario.questions.firstIndex(where: { $0.id == current.id }),
           index + 1 < scenario.questions.count {
            transition(to: scenario.questions[index + 1])
        } else {
            completeScenario()
        }
    }

    private func completeScenario() {
        stopTimer()
        currentQuestion = nil
        isComplete = true
        isActive = false
        print("✅ SCENARIO COMPLETE: Final score: \(score)")
    }
}
