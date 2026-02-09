//
//  Question.swift
//  MaiInHerLoop
//
//  Created by Mai Huynh Ngoc Nhat on 4/2/26.
//
import Foundation

struct Question: Codable, Hashable {
    let id: String
    let textEN: String
    let textVI: String
    let timer: Int
    let options: [Option]

    enum CodingKeys: String, CodingKey {
        case id, timer, options
        case textEN = "text_en"
        case textVI = "text_vi"
    }
    
    // Hashable conformance
    func hash(into hasher: inout Hasher) {
        hasher.combine(id)
    }
    
    static func == (lhs: Question, rhs: Question) -> Bool {
        lhs.id == rhs.id
    }
}
