import Foundation

struct ArchetypeRepository {

    static let archetypes: [String: Archetype] = [

        // MARK: - risk_recognition → Dây thun
        "risk_recognition": Archetype(
            id: "risk_recognition",
            objectImageName: "rubber",
            teaserEN: "First one to notice.",
            teaserVI: "Người đầu tiên để ý.",
            mirrorEN: "You read the room before the room knew it was being read.",
            mirrorVI: "Bạn đọc được không khí trước khi không khí kịp thay đổi.",
            objectExplanationEN: "Nobody buys rubber bands on purpose. They come with the bag of soup from the corner stall, the stack of cash, looped onto a bunch of vegetables at the wet market. Most people toss them, but randomly drop them in a drawer, a pocket, the bottom of a bag, without knowing why. Then one day something needs to be held shut, and they're the only one in the room who has one.",
            objectExplanationVI: "Không ai mua dây thun có chủ đích. Nó theo về từ bịch nước lèo ở quán cóc, từ xấp tiền ở quầy ngân hàng, từ mớ rau ngoài chợ. Đa số người ta vứt đi. Một số người nhét vào ngăn kéo, túi quần, đáy giỏ xách — không biết để làm gì. Rồi một ngày có thứ cần buộc lại, và họ là người duy nhất trong nhà còn dây thun.",
            tradeoffEN: "You notice what's worth keeping, but not everything you hold onto will be needed.",
            tradeoffVI: "Bạn biết thứ gì đáng giữ, nhưng không phải thứ gì giữ lại cũng sẽ có lúc cần.",
            nameEN: "Rubber Bands",
            nameVI: "Cái Nịt",
            imageName: "rubber"
        ),

        // MARK: - information_first → Giỏ nhựa
        "information_first": Archetype(
            id: "information_first",
            objectImageName: "basket",
            teaserEN: "Still works. Never replaced.",
            teaserVI: "Vẫn dùng được. Chưa bao giờ thay.",
            mirrorEN: "You don't move until you know exactly what you're going back for.",
            mirrorVI: "Bạn không đi khi chưa biết mình cần mang về thứ gì.",
            objectExplanationEN: "Mom's basket belongs to a specific empire, the kind you find hanging on a hook in your grandmother's kitchen or tucked under mom's arm at six in the morning. Everyone else switched to tote bags and app delivery, mom kept hers. It still goes to the market, and always comes back full. It never needed to be replaced because it was never broken.",
            objectExplanationVI: "Cái giỏ của mom thuộc về một đế chế khác, thứ bạn thấy móc trên vách bếp của ngoại hoặc nằm trong tay mẹ lúc sáu giờ sáng. Người khác đã chuyển sang túi vải, rồi đặt app. Mẹ vẫn dùng cái giỏ đó, và nó luôn đầy ắp khi trở về. Không cần thay vì chưa bao giờ hỏng.",
            tradeoffEN: "Knowing exactly what you need is a strength, but sometimes the market has already run out by the time you arrive.",
            tradeoffVI: "Biết chính xác mình cần gì là điểm mạnh, nhưng đôi khi ra đến nơi thì chợ đã hết hàng rồi.",
            nameEN: "Mom's Market Basket",
            nameVI: "Giỏ Đi Chợ Của Mẹ",
            imageName: "basket"
        ),

        // MARK: - immediate_action → Dép tổ ong
        "immediate_action": Archetype(
            id: "immediate_action",
            objectImageName: "slipper",
            teaserEN: "Already somewhere it shouldn't be.",
            teaserVI: "Đã ở chỗ không ai ngờ tới.",
            mirrorEN: "You were already in motion before anyone else processed what was going on.",
            mirrorVI: "Bạn đã bắt đầu trước khi người khác hiểu chuyện gì xảy ra.",
            objectExplanationEN: "Somewhere on a busy road in Vietnam right now, there is a single honeycomb slipper, no one knows how it got there. Someday, you will never find the other one because it might flow with flood. It goes everywhere without asking permission, like your dad wear it to the wedding.",
            objectExplanationVI: "Đâu đó trên đường, có một chiếc dép tổ ong nằm lạc lõng, chẳng ai biết nó từ đâu đến. Có khi bạn sẽ không bao giờ tìm thấy chiếc còn lại vì nó đã trôi theo lũ từ lâu. Nó có mặt mọi nơi, như kiểu ba bạn đi dép tổ ong đến đám cưới vậy.",
            tradeoffEN: "It goes everywhere without hesitation, and that's exactly how it ends up alone on a road somewhere.",
            tradeoffVI: "Nó tiến về phia trước không do dự, và cũng là lý do nó nằm giữa đường một mình.",
            nameEN: "A HoneyComb Slipper",
            nameVI: "Dép Tổ Ong",
            imageName: "slipper"
        ),

        // MARK: - self_reliance → Cục gạch
        "self_reliance": Archetype(
            id: "self_reliance",
            objectImageName: "brick",
            teaserEN: "Still there after everything.",
            teaserVI: "Vẫn còn đó sau tất cả.",
            mirrorEN: "You didn't wait for anyone to tell you what to do.",
            mirrorVI: "Bạn không đợi ai nói phải làm gì.",
            objectExplanationEN: "Nobody picks up a brick because they like it. It gets thrown, rained on, left in the yard for years. In Vietnamese slang, calling someone a brick means they feel nothing, react to nothing. But when a storm comes and something needs to be held down, the brick is the thing people reach for. Not because it is smart or fast. Because it is still there, resilience.",
            objectExplanationVI: "Không ai đi nhặt cục gạch cả, nhưng cục gạch có thể 'bị bay', bị mưa dội, và bị lãng quên ngoài sân nhiều năm. Trong tiếng lóng, khi ai đó là cục gạch, điều đó nghĩa là họ đơ, không mặn mà với thứ gì. Nhưng khi cơn 'bão' ập đến, người ta lại cần những 'cục gạch' ấy. Không phải vì nó thông minh hay nhanh nhẹn, mà vì nó vẫn vững vàng còn đó.",
            tradeoffEN: "Being the one who never breaks is its own kind of damage.",
            tradeoffVI: "Là người không bao giờ gãy cũng là một cách bị tổn thương.",
            nameEN: "A Flying Brick",
            nameVI: "Cục Gạch Biết Bay",
            imageName: "brick"
        )
    ]

    static func archetype(for trait: String) -> Archetype? {
        archetypes[trait]
    }
}
