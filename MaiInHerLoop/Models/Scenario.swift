//
//  Scenario.swift
//  MaiInHerLoop
//
//  Created by Mai Huynh Ngoc Nhat on 4/2/26.
//
import Foundation

struct Scenario: Codable, Identifiable, Hashable {
    let id: String
    let region: String
    let danger: Int          // decoded
    let titleEN: String
    let titleVI: String
    let introEN: String
    let introVI: String
    let startQuestionID: String
    let questions: [Question]

    enum CodingKeys: String, CodingKey {
        case id, region, danger, questions
        case titleEN = "title_en"
        case titleVI = "title_vi"
        case introEN = "intro_en"
        case introVI = "intro_vi"
        case startQuestionID = "start_question"
    }

    // decoder "danger" in JSON is a String
    init(from decoder: Decoder) throws {
        let container = try decoder.container(keyedBy: CodingKeys.self)
        id             = try container.decode(String.self,     forKey: .id)
        region         = try container.decode(String.self,     forKey: .region)
        titleEN        = try container.decode(String.self,     forKey: .titleEN)
        titleVI        = try container.decode(String.self,     forKey: .titleVI)
        introEN        = try container.decode(String.self,     forKey: .introEN)
        introVI        = try container.decode(String.self,     forKey: .introVI)
        startQuestionID = try container.decode(String.self,    forKey: .startQuestionID)
        questions      = try container.decode([Question].self, forKey: .questions)

        // "danger" stored as String in JSON → parse to Int, default 1 if missing/invalid
        if let dangerStr = try? container.decode(String.self, forKey: .danger),
           let dangerInt = Int(dangerStr) {
            danger = max(1, min(5, dangerInt))
        } else if let dangerInt = try? container.decode(Int.self, forKey: .danger) {
            danger = max(1, min(5, dangerInt))
        } else {
            danger = 1
        }
    }

    // Memberwise init for previews / tests
    init(id: String, region: String, danger: Int = 1,
         titleEN: String, titleVI: String,
         introEN: String, introVI: String,
         startQuestionID: String, questions: [Question]) {
        self.id              = id
        self.region          = region
        self.danger          = max(1, min(5, danger))
        self.titleEN         = titleEN
        self.titleVI         = titleVI
        self.introEN         = introEN
        self.introVI         = introVI
        self.startQuestionID = startQuestionID
        self.questions       = questions
    }

    // Hashable conformance — id only for performance
    func hash(into hasher: inout Hasher) {
        hasher.combine(id)
    }

    static func == (lhs: Scenario, rhs: Scenario) -> Bool {
        lhs.id == rhs.id
    }
}
