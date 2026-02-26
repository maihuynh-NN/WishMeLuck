import SwiftUI

struct CustomedBorder: ViewModifier {
    let borderShape: String
    let borderColor: Color
    let buttonType: ComponentSize

    func body(content: Content) -> some View {
        let (width, height) = buttonType.size 

        content
            .frame(
                width: buttonType.isFlexible ? nil : width,
                height: height == .infinity ? nil : height
            )
            .frame(
                maxWidth: buttonType.isFlexible ? .infinity : nil
            )
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
                            .allowsHitTesting(false)
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
    VStack(spacing: 20) {
        CustomPanel(
            backgroundColor: Color(.white),
            size: .customed(width: 300, height: 150)
        ) {
            Text("Fixed")
        }
        .customedBorder(borderShape: "panel-border-003", borderColor: Color("Moss"), buttonType: .customed(width: 300, height: 150))

        CustomPanel(
            backgroundColor: Color(.white),
            size: .flexible(height: 150)
        ) {
            Text("Flexible")
        }
        .customedBorder(borderShape: "panel-border-003", borderColor: Color("Moss"), buttonType: .flexible(height: 150))
        .padding(.horizontal, 20)
    }
}
