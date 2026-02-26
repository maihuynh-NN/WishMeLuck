import Foundation

struct StoryBeat {
    let en: String
    let vi: String

    func text(for language: String) -> String {
        language == "vi" ? vi : en
    }
}

let storyBeats: [StoryBeat] = [
    StoryBeat(
        en: """
        Vietnam stretches over 1,600 kilometres from the northern mountains to the southern delta. \
        This length is both its beauty and its burden — no single disaster defines the land, \
        and no single response can save it.
        """,
        vi: """
        Việt Nam trải dài hơn 1.600 km từ vùng núi phía Bắc đến đồng bằng phía Nam. \
        Chiều dài đó vừa là vẻ đẹp, vừa là gánh nặng — không một thiên tai nào định nghĩa được \
        mảnh đất này, và không một cách ứng phó nào có thể cứu tất cả.
        """
    ),
    StoryBeat(
        en: """
        Every year, floods bury the North's valleys. Typhoons tear through the Central coast. \
        Droughts crack the Southern plains. The people rebuild. \
        They always rebuild — because they have learned that survival is a practice, not a moment.
        """,
        vi: """
        Hàng năm, lũ lụt nhấn chìm các thung lũng miền Bắc. Bão tàn phá dải bờ biển miền Trung. \
        Hạn hán làm nứt nẻ đồng bằng miền Nam. Người dân tái thiết. \
        Họ luôn tái thiết — vì họ đã học được rằng sống sót là một hành trình, không phải một khoảnh khắc.
        """
    ),
    StoryBeat(
        en: """
        You are about to enter three regions, each with its own disasters and demands. \
        You will face emergency scenarios under pressure. \
        There are no right or wrong answers — only choices that reveal who you are when it counts.
        """,
        vi: """
        Bạn sắp bước vào ba vùng đất, mỗi nơi mang theo thiên tai và thử thách riêng. \
        Bạn sẽ đối mặt với các tình huống khẩn cấp dưới áp lực. \
        Không có câu trả lời đúng hay sai — chỉ có những lựa chọn cho thấy bạn là ai khi thực sự cần.
        """
    ),
    StoryBeat(
        en: """
        Choose your region. Read the land. Trust your instincts. \
        The disaster does not wait for you to be ready. \
        Neither will the people who need you.
        """,
        vi: """
        Hãy chọn vùng đất của bạn. Đọc hiểu địa hình. Tin vào bản năng. \
        Thiên tai không đợi bạn sẵn sàng. \
        Những người cần bạn cũng vậy.
        """
    )
]
