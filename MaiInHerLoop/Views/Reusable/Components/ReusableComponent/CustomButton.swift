import SwiftUI

// MARK: - Press feedback
struct ScaleButtonStyle: ButtonStyle {
    func makeBody(configuration: Configuration) -> some View {
        configuration.label
            .scaleEffect(configuration.isPressed ? 0.96 : 1.0)
            .animation(.easeOut(duration: 0.15), value: configuration.isPressed)
    }
}

// MARK: - CustomButton
struct CustomButton: View {
    let title: String
    let textColor: Color
    let buttonColor: Color
    let action: () -> Void

    var body: some View {
        Button(action: action) {
            Text(title)
                .font(.system(.body, design: .monospaced).weight(.medium))
                .foregroundStyle(textColor)
                .frame(maxWidth: .infinity, maxHeight: .infinity)
                .background(buttonColor)
        }
        .buttonStyle(ScaleButtonStyle())                
    }
}

#Preview {
    ZStack {
        CustomButton(
            title: "How To Play",
            textColor: Color("Beige"),
            buttonColor: Color("Red"),
            action: {}
        )
        .customedBorder(
            borderShape: "panel-border-005",
            borderColor: Color("Gold"),
            buttonType: .mainButton
        )
    }
}
