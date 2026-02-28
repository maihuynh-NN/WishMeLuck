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
            titleEN: "Welcome To Red Embers",
            titleVI: "Red Embers Chào Bạn",
            bodyEN: """
Sometimes, what harms people is rarely the disaster itself — it's what happens in the minute before and after a decision.

Red Embers is an educational, narrative, and card-based game about decision-making under pressure in Vietnam. The app is structured around three regions: North, Central, and South. Each region contains five scenarios. Each scenario represents one danger category contextualized to that region, so the risks feel local and specific.

Red Embers is built for young adults ranging from 18 to 35, people who navigate between regions for study, work, or economic opportunity around Việt Nam. Young adults are the most capable of action, digitally adept, yet often carrying the weight of decision-making for their household.

In Red Embers, you step into the role of a young adult returning to Vietnam to start over from zero. Vietnam is affordable, culturally rich, and resilient — but it's also layered with risks that don't announce themselves.

The character represents anyone rebuilding on unfamiliar ground, where no one tells you what to do, and the real dangers are often hidden inside ordinary life. This app lets you run the moment once, so if it ever happens for real, your mind has already been there.
""",
            bodyVI: """
Có những lúc, điều làm con người tổn thương không hẳn là bản thân thảm hoạ, mà là những gì xảy ra trong một phút trước và sau khi một quyết định được đưa ra.

Red Embers là một trò chơi giáo dục mang tính tự sự, theo dạng thẻ bài, xoay quanh việc ra quyết định dưới áp lực trong bối cảnh Việt Nam. Ứng dụng được xây dựng dựa trên ba vùng: Bắc, Trung và Nam. Mỗi vùng gồm năm kịch bản. Mỗi kịch bản đại diện cho một nhóm nguy cơ cụ thể gắn với đặc thù của vùng đó, để rủi ro không còn chung chung mà mang tính địa phương, sát với đời sống.

Red Embers hướng đến người trẻ từ 18 đến 35 tuổi, những người di chuyển giữa các vùng để học tập, làm việc hoặc tìm kiếm cơ hội kinh tế trên khắp Việt Nam. Đây là nhóm có khả năng hành động mạnh mẽ, quen thuộc với công nghệ, nhưng cũng thường gánh trên vai những quyết định quan trọng cho gia đình.

Trong Red Embers, bạn vào vai một người trẻ trở về Việt Nam để bắt đầu lại từ con số không. Việt Nam mức sống vừa phải chăng, giàu bản sắc, sức sống bền bỉ, nhưng đồng thời cũng ẩn chứa những rủi ro tiềm ẩn và bất ngờ từ những ngày bình dị.

Nhân vật đại diện cho bất kỳ ai đang xây dựng lại cuộc sống trên một vùng đất chưa quen thuộc, nơi không ai chỉ dẫn sẵn bạn phải làm gì, và những nguy cơ thực sự thường nằm trong những điều rất đời thường.

Ứng dụng này cho bạn trải qua khoảnh khắc ấy một lần trong môi trường an toàn, để nếu ngoài đời thật điều đó xảy ra, bạn không bị đóng băng vì bất ngờ.
"""
        ),

        // MARK: Section 2 — How to navigate the app
        HowToPlaySection(
            titleEN: "How To Navigate",
            titleVI: "Điều Hướng Trong Ứng Dụng",
            bodyEN: """
The app has a few rooms. Here's what each one does.

1. Start Game: When you tap Start Game, you are taken to the Region Selection View. Swipe left or right to browse South, North, and Central.
   - Tap on any card to reveal a sheet for exploring regional content.
   - Or tap the "Choose Region" button to go straight to the Scenario List.

2. Scenario View: There are 5 blind boxes of incidents, categorized by Fire, Flood, Crowd, Heat, and Contamination.
   - When you tap on any scenario, you enter the main game view with a brief preview of the incident. You can either continue or return to the Scenario View.
   - Once you begin, the game is continuous with no pause — because in real life, when you're caught in an incident, you don't get to choose to escape.

3. After the main game ends, you see the Reflection Result View. From here, you can either:
   - Go back to the Scenario View to play another scene, or
   - Visit the Diary View.

4. Diary: This view stores the objects you've collected and records the scenarios you played as a diary journey.

5. Settings: You can:
   - Choose English or Vietnamese
   - Choose dark or light theme
""",
            bodyVI: """
App được chia thành vài “không gian”. Mỗi nơi có một vai trò riêng.

1. Bắt đầu trò chơi: Khi bạn nhấn Start Game, bạn sẽ được đưa đến màn hình chọn vùng. Vuốt sang trái hoặc phải để xem Nam, Bắc và Trung.

* Chạm vào bất kỳ thẻ nào để mở một bảng nội dung giúp bạn khám phá thông tin của vùng đó.
* Hoặc nhấn “Choose Region” để đi thẳng đến danh sách kịch bản.

2. Màn hình kịch bản: Có 5 “hộp mù” tình huống, được phân theo các nhóm: Cháy, Lũ, Đám đông, Nắng nóng và Ô nhiễm.

* Khi bạn chọn một kịch bản, bạn sẽ vào màn chơi chính với phần giới thiệu ngắn về sự cố. Bạn có thể tiếp tục hoặc quay lại danh sách kịch bản.
* Khi đã bắt đầu, trò chơi diễn ra liên tục và không có tạm dừng — vì ngoài đời, khi bị cuốn vào một sự cố, bạn không thể chọn thoát ra giữa chừng.

3. Sau khi kết thúc màn chơi chính, bạn sẽ thấy màn hình Kết quả Phản chiếu. Tại đây, bạn có thể:

* Quay lại danh sách kịch bản để chơi tình huống khác, hoặc
* Mở Nhật ký.

4. Nhật ký: Nơi lưu lại các vật phẩm bạn đã thu thập và ghi lại những kịch bản bạn đã trải qua như một hành trình cá nhân.

5. Cài đặt: Tại đây bạn có thể:

* Chọn ngôn ngữ Tiếng Anh hoặc Tiếng Việt
* Chọn giao diện sáng hoặc tối

"""
        ),

        // MARK: Section 3 — The game mechanism
        HowToPlaySection(
            titleEN: "How To Play In Main Game View",
            titleVI: "Cách Chơi Trong Khung Chơi Chính",
            bodyEN: """
There are no "correct" or "incorrect" answers, and there are no consequences. Every option is something a real person might choose.

Once the game begins, it cannot be paused or returned, so stay focused and act quick.

You are given 7 questions per scenario. Each question comes with 4 options. Each question has a time limit from 10 to 30 seconds, depending on the urgency and severity of the situation.

- Read the question
- Tap one of the four cards
- Watch the time
""",
            bodyVI: """
Không có đáp án “đúng” hay “sai”, và cũng không có hình phạt nào. Mỗi lựa chọn đều là điều mà một người thật ngoài đời có thể đưa ra.

Khi trò chơi bắt đầu, bạn sẽ không thể tạm dừng hay quay lại. Vì vậy, hãy giữ sự tập trung và phản ứng nhanh.

Mỗi kịch bản gồm 7 câu hỏi. Mỗi câu có 4 lựa chọn. Thời gian cho mỗi câu dao động từ 10 đến 30 giây, tùy theo mức độ khẩn cấp và nghiêm trọng của tình huống.

* Đọc câu hỏi
* Chạm vào một trong bốn thẻ
* Theo dõi thời gian
"""
        ),

        // MARK: Section 4 — Reflection & archetype
        HowToPlaySection(
            titleEN: "The Aftermath Of Main Game View",
            titleVI: "Kết Quả Sau Khung Chơi Chính",
            bodyEN: """
When the 7 questions end, you might receive one of four objects from ordinary Vietnamese life: a rubber band, a honeycomb slipper, a mom's market basket, or a brick.

Each object represents a pattern the game observed in how you responded: the way you approached information, whether you acted fast or gathered more before moving, whether you relied on yourself or waited for the group.

These aren't personality tests or a judgment call. They're behavioral snapshots — what you actually did in that specific situation, under that specific pressure. No matter what the outcome is, what you collected is the insight, the experience, and the practical solution. This knowledge is wrapped inside the Diary View.

You're not being labeled. You're being shown a mirror.
""",
            bodyVI: """
Khi 7 câu hỏi kết thúc, bạn có thể nhận được một trong bốn vật dụng quen thuộc trong đời sống Việt Nam: một sợi dây thun, một đôi dép tổ ong, một chiếc giỏ đi chợ của mẹ, hoặc một viên gạch.

Mỗi vật tượng trưng cho một mẫu hành vi mà trò chơi ghi nhận từ cách bạn phản ứng: cách bạn tiếp cận thông tin, bạn hành động ngay hay chờ quan sát thêm, bạn tự mình quyết định hay đợi tập thể.

Đây không phải là bài trắc nghiệm tính cách, cũng không phải một lời phán xét. Đó là một lát cắt hành vi — những gì bạn thực sự đã làm trong đúng tình huống đó, dưới đúng áp lực đó. Dù kết quả là gì, thứ bạn “nhận được” chính là sự thấu hiểu, trải nghiệm, và một cách xử lý thực tế. Tất cả được lưu lại trong mục Nhật ký.

Đây không phải định nghĩa bạn là ai. Chỉ là cách bạn đã hành động trong khoảnh khắc đó.
"""
        ),

        // MARK: Section 5 — Diary
        HowToPlaySection(
            titleEN: "The Diary, Why It Exists",
            titleVI: "Tại Sao Bạn Cần Quyển Nhật Ký Này",
            bodyEN: """
The Diary is not a trophy case. it's a record of what you went through and whats left is a lesson.

Everyone keeps a diary at some point, collects something, rubber bands, rocks, ticket stubs, things that meant nothing until they didn't. 

Your diary here works the same way. It records what you lived through, what you picked up along the way, and what you'd do differently next time. No grades, no lectures. 

Just you, writing it down so you remember.
""",
            bodyVI: """
Nhật ký không phải là nơi trưng bày chiến tích. Nó là ghi chép về những gì bạn đã đi qua, và điều còn lại sau cùng là bài học.

Ai rồi cũng từng giữ một cuốn nhật ký, từng cất lại một thứ gì đó: dây thun, viên đá, cuống vé, những món đồ tưởng chừng chẳng có ý nghĩa gì… cho đến khi chúng bắt đầu có ý nghĩa.

Nhật ký trong ứng dụng này cũng vậy. Nó lưu lại những gì bạn đã trải nghiệm, những gì bạn “nhặt” được trên đường đi, và nếu có lần sau, bạn sẽ làm khác điều gì. Không điểm số. Không bài giảng.

Chỉ là bạn, viết lại để không quên.
"""
        )
    ]
}
