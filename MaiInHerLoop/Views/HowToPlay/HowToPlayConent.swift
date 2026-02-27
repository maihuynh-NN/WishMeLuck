import Foundation

// MARK: - How To Play — Static Content Model

struct HowToPlaySection {
    let titleEN: String
    let titleVI: String
    let bodyEN: String
    let bodyVI: String
}

struct HowToPlayContent {

    static let sections: [HowToPlaySection] = [

        // MARK: Section 1 — What this app is
        HowToPlaySection(
            titleEN: "WHAT YOU'RE WALKING INTO",
            titleVI: "BẠN ĐANG BƯỚC VÀO ĐÂY",
            bodyEN: """
You didn't open a quiz. You opened a room that asks whether you'd survive it.

Mai In Her Loop puts you inside real situations — the kind that have actually happened across Vietnam's three regions. Flash floods at midnight. Apartment fires with one exit. Heat that makes people stop thinking clearly. Every scenario is built from the texture of real life here: the narrow staircases, the motorbikes, the family you're responsible for, the neighbor knocking at 1am.

You play as a Việt Kiều who just landed back in Vietnam after years abroad. You're not ignorant. You've just never had to think about these particular kinds of risk before. You're learning alongside the character — which is the whole point.

This isn't about surviving the apocalypse. It's about the ordinary decisions that turn ordinary disasters into something survivable — or not.
""",
            bodyVI: """
Bạn không mở một bài kiểm tra. Bạn mở một căn phòng và tự hỏi: liệu mình có thoát được không?

Mai In Her Loop đặt bạn vào những tình huống có thật — những chuyện đã xảy ra khắp ba miền Việt Nam. Lũ bùng lúc nửa đêm. Đám cháy chung cư chỉ có một lối thoát. Nắng nóng khiến người ta không còn nghĩ được rõ ràng. Mỗi tình huống được xây dựng từ kết cấu của đời thường: cầu thang hẹp, xe máy, gia đình bạn đang lo, người hàng xóm gõ cửa lúc 1 giờ sáng.

Bạn đóng vai một Việt Kiều vừa trở về sau nhiều năm ở nước ngoài. Bạn không kém cỏi. Bạn chỉ chưa từng phải nghĩ đến những loại rủi ro này. Bạn học cùng nhân vật — đó mới là điều quan trọng.

Đây không phải chuyện sống sót qua tận thế. Đây là những quyết định bình thường biến một thảm họa bình thường thành thứ có thể vượt qua — hoặc không.
"""
        ),

        // MARK: Section 2 — How to navigate the app
        HowToPlaySection(
            titleEN: "FINDING YOUR WAY AROUND",
            titleVI: "ĐIỀU HƯỚNG TRONG ỨNG DỤNG",
            bodyEN: """
The app has a few rooms. Here's what each one does.

The Region Map is where you choose your starting ground — North, Central, or South. Each region carries different terrain, different weather patterns, different kinds of risk. Read the survival orientation brief before you commit.

The Mission Board shows the scenarios available in your region. Tap a card to read the dispatch — the situation briefing. If you're ready, you go in. If not, you retreat and come back.

The Game itself is where decisions happen. You'll read a situation, feel the weight of it, and choose. There's no right answer on the surface. But reality has an opinion.

The Reflection Screen appears after you finish. That's where the real learning lands.

The Diary keeps everything you've played. It's also where your collected objects live.

Need to switch language or toggle dark mode? Open Settings — the gear icon sits in the corner of most screens.
""",
            bodyVI: """
Ứng dụng có vài màn hình. Đây là những gì mỗi màn hình làm.

Bản đồ Vùng là nơi bạn chọn điểm xuất phát — Bắc, Trung hay Nam. Mỗi vùng mang địa hình khác nhau, thời tiết khác nhau, loại rủi ro khác nhau. Đọc cẩm nang định hướng sinh tồn trước khi vào.

Bảng Nhiệm Vụ hiển thị các tình huống trong vùng bạn chọn. Nhấn vào thẻ để đọc điện khẩn — bản tóm tắt tình huống. Nếu sẵn sàng, bạn bước vào. Nếu chưa, lui lại và quay sau.

Chính Trò Chơi là nơi quyết định xảy ra. Bạn đọc tình huống, cảm nhận sức nặng của nó, rồi chọn. Bề ngoài không có đáp án đúng. Nhưng thực tế thì có.

Màn Hình Suy Ngẫm xuất hiện sau khi bạn hoàn thành. Đó là nơi bài học thực sự đọng lại.

Nhật Ký lưu tất cả những gì bạn đã chơi. Đó cũng là nơi những vật phẩm bạn thu thập được sống.

Cần chuyển ngôn ngữ hoặc bật chế độ tối? Mở Cài Đặt — biểu tượng bánh răng ở góc hầu hết các màn hình.
"""
        ),

        // MARK: Section 3 — The game mechanism
        HowToPlaySection(
            titleEN: "HOW THE GAME ACTUALLY WORKS",
            titleVI: "CÁCH TRÒ CHƠI VẬN HÀNH",
            bodyEN: """
Each scenario has seven moments. Not questions — moments.

The story builds before anything asks you to choose. By the time the choice appears, you're already inside the situation. You've met the characters. You've felt the pressure rising. That's deliberate.

When the choice arrives, all four options feel reasonable. That's also deliberate. In real emergencies, bad decisions rarely feel obviously bad. The person who drove their motorbike into floodwater wasn't being reckless — they thought it was manageable.

There's a timer. Not to punish you — to mirror reality. In a flash flood, in a building fire, in a crowd crush, the window for deciding closes fast. Waiting is itself a choice, and not always the right one.

Play seven moments. Each choice affects what comes next. The story tracks your decisions. At the end, it reflects them back.
""",
            bodyVI: """
Mỗi tình huống có bảy khoảnh khắc. Không phải câu hỏi — là khoảnh khắc.

Câu chuyện được xây dựng trước khi có bất kỳ yêu cầu nào bắt bạn chọn. Khi lựa chọn xuất hiện, bạn đã ở trong tình huống rồi. Bạn đã gặp các nhân vật. Bạn đã cảm nhận áp lực dâng lên. Điều đó là cố ý.

Khi lựa chọn đến, cả bốn phương án đều có vẻ hợp lý. Điều đó cũng cố ý. Trong tình huống khẩn cấp thực tế, quyết định sai hiếm khi trông rõ ràng là sai. Người lái xe máy vào đường ngập không phải vì liều lĩnh — họ nghĩ vẫn qua được.

Có đồng hồ đếm ngược. Không phải để phạt bạn — mà để phản ánh thực tế. Trong lũ quét, trong đám cháy, trong đám đông chen chúc, cửa sổ để quyết định đóng rất nhanh. Chờ đợi cũng là một lựa chọn, và không phải lúc nào cũng đúng.

Chơi qua bảy khoảnh khắc. Mỗi lựa chọn ảnh hưởng đến những gì xảy ra tiếp theo. Câu chuyện theo dõi các quyết định của bạn. Kết thúc, nó phản chiếu lại những quyết định đó.
"""
        ),

        // MARK: Section 4 — Reflection & archetype
        HowToPlaySection(
            titleEN: "THE OBJECT YOU TAKE HOME",
            titleVI: "VẬT PHẨM BẠN MANG VỀ",
            bodyEN: """
When the scenario ends, the game shows you something unexpected: an object.

Not a score. Not a rank. An object from ordinary Vietnamese life — a rubber band, a foam slipper, a market basket, a brick.

Each object represents a pattern the game observed in how you responded. The way you approached information. Whether you acted fast or gathered more before moving. Whether you relied on yourself or waited for the group. These aren't personality tests. They're behavioral snapshots — what you actually did in that specific situation, under that specific pressure.

The four objects you might receive:

Rubber Bands · Market Basket · Honeycomb Slipper · A Brick

Each one carries a clear-eyed description of what that behavior looks like in a crisis — including its blind spot. Because every instinct that saves you in one scenario can get you killed in another.

You're not being labeled. You're being shown a mirror.
""",
            bodyVI: """
Khi tình huống kết thúc, trò chơi cho bạn thấy điều bất ngờ: một vật phẩm.

Không phải điểm số. Không phải xếp hạng. Một vật phẩm từ đời thường Việt Nam — cái nịt, dép tổ ong, giỏ chợ, cục gạch.

Mỗi vật phẩm đại diện cho một khuôn mẫu mà trò chơi quan sát được trong cách bạn phản ứng. Cách bạn tiếp cận thông tin. Bạn hành động nhanh hay thu thập thêm trước khi di chuyển. Bạn tự dựa vào bản thân hay chờ đợi tập thể. Đây không phải bài kiểm tra tính cách. Đây là ảnh chụp hành vi — những gì bạn thực sự làm trong tình huống cụ thể đó, dưới áp lực cụ thể đó.

Bốn vật phẩm bạn có thể nhận được:

Cái Nịt · Giỏ Chợ Của Mẹ · Dép Tổ Ong · Cục Gạch

Mỗi vật phẩm mang theo mô tả rõ ràng về hành vi đó trông như thế nào trong khủng hoảng — kể cả điểm mù của nó. Vì mỗi bản năng cứu bạn trong tình huống này có thể giết bạn trong tình huống khác.

Bạn không bị dán nhãn. Bạn đang được nhìn vào gương.
"""
        ),

        // MARK: Section 5 — Diary
        HowToPlaySection(
            titleEN: "THE DIARY — WHY IT EXISTS",
            titleVI: "NHẬT KÝ — TẠI SAO NÓ TỒN TẠI",
            bodyEN: """
The Diary is not a trophy case. It's a record of what you went through and what it cost.

Every scenario you complete leaves an entry. Open it and you'll find the insight — not a lecture on disaster preparedness, but the real thing: what actually happened to people who made similar choices in that specific kind of crisis in Vietnam. The research behind each scenario is real. The statistics are real. The names aren't, but the situations are.

The collection panel shows every object you've earned. Play different scenarios and you may find yourself receiving different objects — because different pressures reveal different instincts. The person who is a Brick in a flood situation might be a Market Basket in a fire.

We built the Diary because we believe knowing what happened matters more than knowing what you scored. A score fades. An insight about why 56 people died in a tube house fire because there was one exit and no alarm — that stays.

That's what this app is actually trying to do. Not teach you survival rules. Teach you why the rules exist in the first place.
""",
            bodyVI: """
Nhật Ký không phải tủ trưng bày. Đó là hồ sơ về những gì bạn đã trải qua và cái giá của nó.

Mỗi tình huống bạn hoàn thành để lại một mục. Mở ra và bạn sẽ thấy bài học — không phải bài giảng về phòng chống thiên tai, mà là điều thực sự: những gì đã xảy ra với những người đưa ra lựa chọn tương tự trong đúng loại khủng hoảng đó ở Việt Nam. Nghiên cứu đằng sau mỗi tình huống là có thật. Con số thống kê là có thật. Tên không có thật, nhưng tình huống thì có.

Bảng sưu tập hiển thị mọi vật phẩm bạn đã kiếm được. Chơi các tình huống khác nhau và bạn có thể thấy mình nhận được những vật phẩm khác nhau — vì áp lực khác nhau bộc lộ bản năng khác nhau. Người là Cục Gạch trong tình huống lũ lụt có thể là Giỏ Chợ trong đám cháy.

Chúng tôi xây dựng Nhật Ký vì chúng tôi tin rằng biết điều gì đã xảy ra quan trọng hơn biết bạn đạt bao nhiêu điểm. Điểm số mờ dần. Còn sự hiểu biết về lý do tại sao 56 người chết trong một vụ cháy nhà ống vì chỉ có một lối thoát và không có chuông báo động — điều đó ở lại.

Đó là điều ứng dụng này thực sự đang cố gắng làm. Không phải dạy bạn quy tắc sinh tồn. Mà dạy bạn tại sao những quy tắc đó tồn tại ngay từ đầu.
"""
        )
    ]
}
