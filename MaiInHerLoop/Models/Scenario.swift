import Foundation

struct Scenario: Codable, Identifiable, Hashable {
    let id: String
    let region: String
    let danger: Int          // decoded
    let titleEN: String
    let titleVI: String
    let introEN: String
    let introVI: String
    let insightEN: String   // "" if not yet in JSON
    let insightVI: String   // "" if not yet in JSON
    let startQuestionID: String
    let questions: [Question]

    enum CodingKeys: String, CodingKey {
        case id, region, danger, questions
        case titleEN         = "title_en"
        case titleVI         = "title_vi"
        case introEN         = "intro_en"
        case introVI         = "intro_vi"
        case insightEN       = "insight_en"
        case insightVI       = "insight_vi"
        case startQuestionID = "start_question"
    }

    init(from decoder: Decoder) throws {
        let c = try decoder.container(keyedBy: CodingKeys.self)
        id              = try c.decode(String.self,     forKey: .id)
        region          = try c.decode(String.self,     forKey: .region)
        titleEN         = try c.decode(String.self,     forKey: .titleEN)
        titleVI         = try c.decode(String.self,     forKey: .titleVI)
        introEN         = try c.decode(String.self,     forKey: .introEN)
        introVI         = try c.decode(String.self,     forKey: .introVI)
        insightEN       = (try? c.decode(String.self,   forKey: .insightEN)) ?? ""
        insightVI       = (try? c.decode(String.self,   forKey: .insightVI)) ?? ""
        startQuestionID = try c.decode(String.self,     forKey: .startQuestionID)
        questions       = try c.decode([Question].self, forKey: .questions)
        
        if let dangerStr = try? c.decode(String.self, forKey: .danger),
                   let dangerInt = Int(dangerStr) {
                    danger = max(1, min(5, dangerInt))
                } else if let dangerInt = try? c.decode(Int.self, forKey: .danger) {
                    danger = max(1, min(5, dangerInt))
                } else {
                    danger = 1
                }
    }

    // Memberwise init for previews / tests
    init(id: String, region: String, danger: Int = 1,
         titleEN: String, titleVI: String,
         introEN: String, introVI: String,
         insightEN: String = "", insightVI: String = "",
         startQuestionID: String, questions: [Question]) {
        self.id              = id
        self.region          = region
        self.danger          = max(1, min(5, danger))
        self.titleEN         = titleEN
        self.titleVI         = titleVI
        self.introEN         = introEN
        self.introVI         = introVI
        self.insightEN       = insightEN
        self.insightVI       = insightVI
        self.startQuestionID = startQuestionID
        self.questions       = questions
    }

    func hash(into hasher: inout Hasher) { hasher.combine(id) }
    static func == (lhs: Scenario, rhs: Scenario) -> Bool { lhs.id == rhs.id }
}
