//
//  ArchetypeRepository.swift
//  MaiInHerLoop
//
//  Created by Mai Huynh Ngoc Nhat on 6/2/26.
//
import Foundation

struct ArchetypeRepository {

    static let archetypes: [String: Archetype] = [

        // MARK: - risk_recognition → Dây thun
        "risk_recognition": Archetype(
            id: "risk_recognition",
            objectImageName: "rubber",
            teaserEN: "Tight before it snaps.",
            teaserVI: "Căng trước khi đứt.",
            mirrorEN: "You felt something was wrong before anyone else noticed anything.",
            mirrorVI: "Bạn biết có gì đó không ổn trước khi người khác kịp nhận ra.",
            objectExplanationEN: "Rubber bands are everywhere in Vietnam — bundling cash at the bank, holding vegetables at the wet market, looped on doorknobs waiting to be useful. People collect them without meaning to. They stretch quietly until something finally snaps.",
            objectExplanationVI: "Dây thun có mặt ở khắp nơi — buộc tiền ở ngân hàng, buộc rau ở chợ, quấn quanh tay nắm cửa chờ lúc cần. Người ta nhặt về mà không biết từ khi nào. Căng thầm lặng — cho đến khi đứt.",
            tradeoffEN: "Not every tension means something is about to break.",
            tradeoffVI: "Không phải lần nào căng cũng là sắp đứt.",
            nameEN: "Early Signal Reader",
            nameVI: "Người Nhận Diện Sớm",
            imageName: "rubber"
        ),

        // MARK: - information_first → Giỏ nhựa
        "information_first": Archetype(
            id: "information_first",
            objectImageName: "basket",
            teaserEN: "Never leaves empty.",
            teaserVI: "Không đi tay không.",
            mirrorEN: "You don't leave until you know what you're going back for.",
            mirrorVI: "Bạn không ra đi khi chưa biết mình cần mang về thứ gì.",
            objectExplanationEN: "The plastic market basket doesn't go to the market empty and come back full by accident. It has compartments. It knows what's missing before you do. Your mom's version of this basket has seen more crises than most emergency kits.",
            objectExplanationVI: "Cái giỏ chợ không tự nhiên ra đi tay không rồi về đầy. Nó có ngăn, có chỗ. Nó biết thứ gì còn thiếu trước khi bạn nghĩ ra. Cái giỏ của mẹ bạn đã trải qua nhiều khủng hoảng hơn bất kỳ túi cứu trợ nào.",
            tradeoffEN: "A full basket takes time — and sometimes you need to go before it's ready.",
            tradeoffVI: "Giỏ đầy cần thời gian — mà đôi khi không có thời gian để đợi đầy.",
            nameEN: "Deliberate Analyst",
            nameVI: "Người Phân Tích Thận Trọng",
            imageName: "basket"
        ),

        // MARK: - immediate_action → Dép tổ ong
        "immediate_action": Archetype(
            id: "immediate_action",
            objectImageName: "slipper",
            teaserEN: "Already moving.",
            teaserVI: "Đã đi là đi.",
            mirrorEN: "When things went wrong, you were already moving.",
            mirrorVI: "Khi có chuyện, bạn đã đi rồi.",
            objectExplanationEN: "The foam slipper doesn't care about terrain. It has been spotted in flood footage floating down Mekong tributaries, surviving better than most things. Its official use is for walking. Its actual use is for everything. It's the footwear equivalent of not overthinking.",
            objectExplanationVI: "Dép tổ ong không quan tâm đường xá ra sao. Nó đã từng được nhìn thấy trôi bồng bềnh trên kênh mùa lũ miền Tây — và vẫn còn nguyên. Nó được tạo ra để đi. Thực ra nó được dùng cho mọi thứ. Đây là chiếc dép của người không có thời gian suy nghĩ nhiều.",
            tradeoffEN: "Moving fast gets you out — but sometimes the people behind you don't know why they're running.",
            tradeoffVI: "Đi nhanh giúp bạn thoát — nhưng đôi khi người đằng sau không biết tại sao mình đang chạy.",
            nameEN: "Decisive Mover",
            nameVI: "Người Hành Động Quyết Đoán",
            imageName: "slipper"
        ),

        // MARK: - self_reliance → Cục gạch
        "self_reliance": Archetype(
            id: "self_reliance",
            objectImageName: "brick",
            teaserEN: "Needs nothing else.",
            teaserVI: "Không cần thêm gì.",
            mirrorEN: "You didn't wait for anyone to tell you what to do.",
            mirrorVI: "Bạn không đợi ai nói phải làm gì.",
            objectExplanationEN: "Bricks hold down tarp during storms. They prop open gates. In Central Vietnam, they sit on rooftops not as decoration, but as weight — quiet, functional, asking nothing from anyone. The brick doesn't need instructions. It just does its job.",
            objectExplanationVI: "Gạch được dùng để chặn bạt mái khi bão. Chặn cửa. Đặt trên mái nhà miền Trung không phải để trang trí — mà để giữ mái khỏi bay. Cục gạch không cần ai chỉ dẫn. Nó chỉ làm việc của nó.",
            tradeoffEN: "A brick alone holds weight — but it can't bend, and it can't ask for help.",
            tradeoffVI: "Một mình thì vững — nhưng không thể uốn, và không biết kêu ai.",
            nameEN: "Independent Operator",
            nameVI: "Người Tự Chủ",
            imageName: "brick"
        )
    ]

    static func archetype(for trait: String) -> Archetype? {
        archetypes[trait]
    }
}
