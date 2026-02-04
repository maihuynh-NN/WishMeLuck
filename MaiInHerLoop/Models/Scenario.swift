//
//  Scenario.swift
//  MaiInHerLoop
//
//  Created by Mai Huynh Ngoc Nhat on 4/2/26.
//
import Foundation

struct Scenario: Codable {
    let id: String
    let region: String
    let titleEN: String
    let titleVI: String
    let introEN: String
    let introVI: String
    let startQuestionID: String
    let questions: [Question]

    enum CodingKeys: String, CodingKey {
        case id, region, questions
        case titleEN = "title_en"
        case titleVI = "title_vi"
        case introEN = "intro_en"
        case introVI = "intro_vi"
        case startQuestionID = "start_question"
    }
}
