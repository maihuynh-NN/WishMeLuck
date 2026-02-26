import Foundation

struct Option: Codable, Hashable {
    let id: String
    let textEN: String
    let textVI: String
    let traitTag: String
    let nextQuestionID: String?

    enum CodingKeys: String, CodingKey {
        case id
        case textEN = "text_en"
        case textVI = "text_vi"
        case traitTag = "trait_tag"
        case nextQuestionID = "next_question"
    }
    
    func hash(into hasher: inout Hasher) {
        hasher.combine(id)
    }
    
    static func == (lhs: Option, rhs: Option) -> Bool {
        lhs.id == rhs.id
    }
}
