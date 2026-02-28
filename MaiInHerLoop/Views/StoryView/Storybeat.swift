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
        [Name] left Vietnam young, too young to remember much beyond airport lights and moms' hand gripping theirs too tight. 
        
        Grew up abroad chasing paper-perfect success: the degree, the venture, the approval.
        
        The apartment framed by glass and skyline, where the lights stayed on long after midnight. 
        
        It worked, for a while.
        """,
        vi: """
        [Name] rời Việt Nam khi còn quá nhỏ. Ký ức chỉ còn ánh đèn sân bay nhòe đi trong mắt và bàn tay mẹ ghì chặt.

        Lớn lên ở xứ người, họ miệt mài theo đuổi một kiểu thành công hình mẫu: những tấm bằng, những dự án, những sự công nhận từ những người quyết định cuộc chơi.

        Căn hộ kính cao tầng, nhìn thẳng ra đường chân trời. Đèn vẫn sáng sau nửa đêm, dường như sự nghỉ ngơi là một thứ xa xỉ nhất.

        Khi ấy, mọi thứ vẫn còn đứng vững
        """
    ),
    StoryBeat(
        en: """
        [Name] spent years performing success, the venture sustained by glamorous dinners and introductions where nothing was ever fully written down.
        
        Private lenders, handshake extensions, interest rates discussed without numbers. Capital was always “about to land”, but it never did.

        The last call wasn’t from an investor. It was from someone who doesn’t leave voicemails.
        """,
        vi: """
        [Name] đã dành nhiều năm đánh bóng sự thành đạt, giữ dự án tồn tại bằng những bữa tối sang trọng, những cái gật đầu sau cánh cửa đóng kín, không tiện nằm trên giấy.

        Vốn tư nhân, gia hạn bằng bắt tay, lãi suất nói vòng, không bao giờ đặt lên bàn. Tiền thì luôn ‘sắp về’, nhưng mãi chưa thấy tới.

        Cuộc gọi cuối không phải của nhà đầu tư, mà của người không bao giờ để lại tin nhắn.
        """
    ),
    StoryBeat(
        en: """
        [Name] wakes up one morning and realize they'd been renting their entire life from people who wanted it back.
        
        The phone wouldn't stop ringing, the lynch mob wouldn't need names.
        
        Their "Western Dream" is dead, they wanted to leave everything behind to become a ghost.
        """,
        vi: """
        [Name] thức dậy vào một buổi sáng và nhận ra cả đời mình chỉ là đang mượn — mượn giấc mơ, mượn hào quang, sống trong cái bóng của những người giờ đây muốn lấy lại tất cả.
        
        Điện thoại reo không ngừng. Đám đông ngoài kia chẳng cần biết tên.

        ‘Giấc mơ phương Tây’ đã chết. Họ chỉ muốn bỏ lại mọi thứ phía sau, biến mình thành một cái bóng.
        """
    ),
    StoryBeat(
        en: """
        [Name] picked Vietnam the way you pick a seat on a late-night bus, a country where $2.50 bowl of phở fills the hunger, lower rent, and fewer expectations.
        
        2 A.M. Fifteen degrees. The terminal is half-asleep. [Name] sits with a one-way ticket, one suitcase, and a phone full of numbers that won't work anymore. 
        
        [Name] felt the terrifying freedom of absolute zero, and beneath it, a pulse of something almost like awaiting.
        """,
        vi: """
        [Name] chọn Việt Nam như cách người ta chọn một chỗ ngồi trên chuyến xe đêm, một nơi mà bát phở 2,5 đô có thể lấp đầy cơn đói, tiền thuê nhà nhẹ hơn, và kỳ vọng cũng nhẹ hơn.

        2 giờ sáng, mười lăm độ. Nhà ga còn lơ mơ buồn ngủ, [Name] ngồi đó với tấm vé một chiều, một vali, và chiếc điện thoại đầy những số sẽ không còn liên lạc nữa.
        
        [Name] cảm nhận được thứ tự do rợn người của con số không tuyệt đối, và bên dưới nó, là một nhịp đập của điều gì đó gần giống như sự chờ đợi.
        """
    ),
    StoryBeat(
        en: """
        Ahead is a country that doesn't know they're coming, but it will ask them questions they've never had to answer before.
        """,
        vi: """
        Phía trước là một đất nước không biết họ sẽ đến, nhưng sẽ đặt ra những câu hỏi mà trước đây họ chưa từng phải tự trả lời.
        """
    )
]
