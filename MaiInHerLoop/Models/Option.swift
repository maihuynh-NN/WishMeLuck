//
//  Option.swift
//  MaiInHerLoop
//
//  Created by Mai Huynh Ngoc Nhat on 4/2/26.
//
import Foundation

struct Option: Codable {
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
}
