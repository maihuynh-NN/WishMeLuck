//
//  ArchetypeRepository.swift
//  MaiInHerLoop
//
//  Created by Mai Huynh Ngoc Nhat on 6/2/26.
//

import Foundation

struct ArchetypeRepository {

    static let archetypes: [String: Archetype] = [

        "tap_the": Archetype(
            id: "tap_the",
            nameEN: "The Collective Anchor",
            nameVI: "Người Đồng Đội",
            recognitionEN: "When things became unstable, you moved toward people.",
            recognitionVI: "Khi tình huống trở nên bất ổn, bạn tìm đến con người.",
            bulletsEN: [
                "You checked on others before securing yourself.",
                "You stayed when coordination mattered.",
                "You responded to panic instead of avoiding it."
            ],
            bulletsVI: [
                "Bạn quan tâm đến người khác trước khi lo cho bản thân.",
                "Bạn ở lại khi sự phối hợp trở nên quan trọng.",
                "Bạn đối diện với hoảng loạn thay vì tránh né."
            ],
            strengthEN: "You naturally pull people into order when fear spreads.",
            blindSpotEN: "You may carry too much before asking for help.",
            directionEN: "Your strength grows when you let others support you too."
        )

        // Other archetypes later
    ]

    static func archetype(for trait: String) -> Archetype? {
        archetypes[trait]
    }
}
