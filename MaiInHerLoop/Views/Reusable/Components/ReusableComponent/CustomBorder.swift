import SwiftUI

struct CustomedBorder: ViewModifier {
    let borderShape: String
    let borderColor: Color
    let buttonType: ComponentSize

    func body(content: Content) -> some View {
        let (width, height) = buttonType.size

        content
            .frame(width: width, height: height)
            .overlay(
                Group {
                    if UIImage(named: borderShape) != nil {
                        Image(borderShape)
                            .resizable(
                                capInsets: EdgeInsets(top: 8, leading: 8, bottom: 8, trailing: 8),
                                resizingMode: .stretch
                            )
                            .renderingMode(.template)
                            .foregroundStyle(borderColor)
                            .allowsHitTesting(false)  // ← KEY FIX: overlay never blocks taps
                    }
                }
            )
    }
}

extension View {
    func customedBorder(borderShape: String, borderColor: Color, buttonType: ComponentSize) -> some View {
        self.modifier(CustomedBorder(
            borderShape: borderShape,
            borderColor: borderColor,
            buttonType: buttonType
        ))
    }
}
#Preview {
    CustomPanel(
        backgroundColor: Color(.white),
        size: .customed(width: 300, height: 500)
    ) {
        VStack {
            Text("Profile")
        }
    }
        .customedBorder(
            borderShape: "panel-border-003",
            borderColor: Color("Moss"),
            buttonType: .customed(width: 300, height: 500)
        )
}
