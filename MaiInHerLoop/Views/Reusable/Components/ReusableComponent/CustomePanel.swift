import SwiftUI

struct CustomPanel<Content: View>: View {
    let backgroundColor: Color
    let size: ComponentSize
    let content: () -> Content

    var body: some View {
        let (width, height) = size.size

        ZStack {
            content()
        }
        .frame(
            maxWidth: size.isFlexible ? .infinity : width,
            maxHeight: height == .infinity ? nil : height
        )
        .frame(
            width: size.isFlexible ? nil : width,
            height: height == .infinity ? nil : height
        )
        .background(backgroundColor.opacity(0.4))
    }
}

#Preview {
    VStack(spacing: 20) {
        CustomPanel(
            backgroundColor: Color("Moss"),
            size: .customed(width: 300, height: 200)
        ) {
            Text("Fixed panel")
        }
        .customedBorder(borderShape: "panel-border-003", borderColor: Color("Moss"), buttonType: .customed(width: 300, height: 200))

        CustomPanel(
            backgroundColor: Color("Moss"),
            size: .flexible(height: 200)
        ) {
            Text("Flexible panel")
        }
        .customedBorder(borderShape: "panel-border-003", borderColor: Color("Moss"), buttonType: .flexible(height: 200))
        .padding(.horizontal, 20)
    }
}
