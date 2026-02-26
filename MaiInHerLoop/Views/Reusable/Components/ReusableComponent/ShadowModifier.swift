import SwiftUI

struct ShadowModifier: ViewModifier {
    let color: Color
    
    func body(content: Content) -> some View {
        content
            .shadow(color: color, radius: 4)
        
    }
}
