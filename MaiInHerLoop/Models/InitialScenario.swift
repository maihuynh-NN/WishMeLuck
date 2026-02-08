//
//  InitialScenario.swift
//  MaiInHerLoop
//
//  Created by Mai Huynh Ngoc Nhat on 8/2/26.
//
import Foundation

enum InitialScenario {
    static let northEasy = Scenario(
        id: "north_easy_1",
        region: "north",
        titleEN: "Flash Flood in Hanoi",
        titleVI: "Lũ quét ở Hà Nội",
        introEN: "Heavy rain has caused sudden flooding.",
        introVI: "Mưa lớn gây ra lũ quét bất ngờ.",
        startQuestionID: "q1",
        questions: [
            // use ONE real Question for now
            Question(
                id: "q1",
                textEN: "Water is rising. What do you do?",
                textVI: "Nước đang dâng. Bạn làm gì?",
                timer: 25,
                options: [
                    Option(
                        id: "q1_a",
                        textEN: "Move to a higher floor",
                        textVI: "Di chuyển lên tầng cao hơn",
                        traitTag: "tap_the",
                        nextQuestionID: nil
                    )
                ]
            )
        ]
    )
}

