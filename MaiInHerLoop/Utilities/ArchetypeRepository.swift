//
//  ArchetypeRepository.swift
//  MaiInHerLoop
//
//  Created by Mai Huynh Ngoc Nhat on 6/2/26.
//
import Foundation

struct ArchetypeRepository {
    
    static let archetypes: [String: Archetype] = [
        
        // ARCHETYPE 1: Risk Recognition
        "risk_recognition": Archetype(
            id: "risk_recognition",
            nameEN: "Early Signal Reader",
            nameVI: "Người Nhận Diện Sớm", // [VI_NEEDED]
            definitionEN: "Acts on early warning signals before danger becomes obvious",
            definitionVI: "[VI_NEEDED] Hành động khi có tín hiệu cảnh báo sớm trước khi nguy hiểm rõ ràng",
            imageName: "eye.circle.fill",
            
            recognitionEN: "You reacted when the situation still felt uncertain, before it clearly became dangerous.",
            recognitionVI: "[VI_NEEDED] Bạn phản ứng khi tình huống còn không chắc chắn, trước khi nó rõ ràng trở nên nguy hiểm.",
            
            bulletsEN: [
                "You treated small changes as meaningful",
                "You didn't wait for confirmation to take risk seriously"
            ],
            bulletsVI: [
                "[VI_NEEDED] Bạn coi những thay đổi nhỏ là có ý nghĩa",
                "[VI_NEEDED] Bạn không đợi xác nhận để coi nguy cơ là nghiêm trọng"
            ],
            
            strengthEN: "Early movement prevents being trapped by fast-changing conditions.",
            strengthVI: "[VI_NEEDED] Di chuyển sớm ngăn bị mắc kẹt bởi điều kiện thay đổi nhanh.",
            
            blindSpotEN: "Unclear signals turn out to be noise rather than real escalation.",
            blindSpotVI: "[VI_NEEDED] Tín hiệu không rõ ràng có thể chỉ là nhiễu thay vì leo thang thực sự.",
            
            directionEN: "Trust your instinct, but verify when time allows.",
            directionVI: "[VI_NEEDED] Tin vào trực giác, nhưng xác minh khi có thời gian."
        ),
        
        // ARCHETYPE 2: Information First
        "information_first": Archetype(
            id: "information_first",
            nameEN: "Deliberate Analyst",
            nameVI: "Người Phân Tích Thận Trọng", // [VI_NEEDED]
            definitionEN: "Prioritizes understanding the situation before committing to action",
            definitionVI: "[VI_NEEDED] Ưu tiên hiểu tình huống trước khi cam kết hành động",
            imageName: "chart.bar.doc.horizontal.fill",
            
            recognitionEN: "You slowed yourself down to understand what was happening before committing to action.",
            recognitionVI: "[VI_NEEDED] Bạn làm chậm lại để hiểu điều gì đang xảy ra trước khi cam kết hành động.",
            
            bulletsEN: [
                "You checked for signals, updates, or patterns",
                "You avoided acting on impulse"
            ],
            bulletsVI: [
                "[VI_NEEDED] Bạn kiểm tra tín hiệu, cập nhật, hoặc mô hình",
                "[VI_NEEDED] Bạn tránh hành động theo bản năng"
            ],
            
            strengthEN: "Good information meaningfully changes the safest next step.",
            strengthVI: "[VI_NEEDED] Thông tin tốt thay đổi đáng kể bước tiếp theo an toàn nhất.",
            
            blindSpotEN: "Waiting for certainty costs time you don't actually have.",
            blindSpotVI: "[VI_NEEDED] Đợi sự chắc chắn tốn thời gian bạn không thực sự có.",
            
            directionEN: "Balance gathering information with readiness to move.",
            directionVI: "[VI_NEEDED] Cân bằng thu thập thông tin với sẵn sàng di chuyển."
        ),
        
        // ARCHETYPE 3: Immediate Action
        "immediate_action": Archetype(
            id: "immediate_action",
            nameEN: "Decisive Mover",
            nameVI: "Người Hành Động Quyết Đoán", // [VI_NEEDED]
            definitionEN: "Moves quickly with available information rather than waiting for perfect options",
            definitionVI: "[VI_NEEDED] Di chuyển nhanh với thông tin có sẵn thay vì đợi lựa chọn hoàn hảo",
            imageName: "figure.run.circle.fill",
            
            recognitionEN: "You moved with what you had instead of waiting for better options.",
            recognitionVI: "[VI_NEEDED] Bạn di chuyển với những gì bạn có thay vì đợi lựa chọn tốt hơn.",
            
            bulletsEN: [
                "You accepted imperfect choices",
                "You prioritized momentum over completeness"
            ],
            bulletsVI: [
                "[VI_NEEDED] Bạn chấp nhận lựa chọn không hoàn hảo",
                "[VI_NEEDED] Bạn ưu tiên động lực hơn sự hoàn chỉnh"
            ],
            
            strengthEN: "Delay increases danger more than imperfect action.",
            strengthVI: "[VI_NEEDED] Trì hoãn tăng nguy hiểm hơn hành động không hoàn hảo.",
            
            blindSpotEN: "Situations require coordination instead of speed.",
            blindSpotVI: "[VI_NEEDED] Tình huống yêu cầu phối hợp thay vì tốc độ.",
            
            directionEN: "Your speed is valuable—use it to help others organize.",
            directionVI: "[VI_NEEDED] Tốc độ của bạn có giá trị—dùng nó để giúp người khác tổ chức."
        ),
        
        // ARCHETYPE 4: Self-Reliance
        "self_reliance": Archetype(
            id: "self_reliance",
            nameEN: "Independent Operator",
            nameVI: "Người Tự Chủ", // [VI_NEEDED]
            definitionEN: "Trusts personal judgment and acts without waiting for external direction",
            definitionVI: "[VI_NEEDED] Tin vào phán đoán cá nhân và hành động mà không đợi chỉ đạo bên ngoài",
            imageName: "person.circle.fill",
            
            recognitionEN: "You trusted your own judgment and acted without waiting for direction.",
            recognitionVI: "[VI_NEEDED] Bạn tin vào phán đoán của mình và hành động mà không đợi chỉ đạo.",
            
            bulletsEN: [
                "You relied on personal assessment",
                "You stayed active while others waited"
            ],
            bulletsVI: [
                "[VI_NEEDED] Bạn dựa vào đánh giá cá nhân",
                "[VI_NEEDED] Bạn duy trì hoạt động trong khi người khác chờ đợi"
            ],
            
            strengthEN: "Systems fail, communication breaks, or help arrives late.",
            strengthVI: "[VI_NEEDED] Hệ thống thất bại, giao tiếp bị gián đoạn, hoặc sự giúp đỡ đến muộn.",
            
            blindSpotEN: "Shared decisions reduce risk better than acting alone.",
            blindSpotVI: "[VI_NEEDED] Quyết định chung giảm rủi ro tốt hơn hành động một mình.",
            
            directionEN: "Your self-sufficiency is a resource others can learn from.",
            directionVI: "[VI_NEEDED] Sự tự cung tự cấp của bạn là nguồn lực người khác có thể học hỏi."
        )
    ]
    
    static func archetype(for trait: String) -> Archetype? {
        archetypes[trait]
    }
}
