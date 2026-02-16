import SwiftUI

struct NorthernMistBackground: View {
    var body: some View {
        ZStack {
            LinearGradient(
                colors: [
                    Color.orange.opacity(0.2),
                    Color.green,
                    Color.orange.opacity(0.1)
                ],
                startPoint: .top,
                endPoint: .bottom
            )

            Circle()
                .fill(Color.black.opacity(0.15))
                .frame(width: 400)
                .blur(radius: 80)
                .offset(y: -150)

            Circle()
                .fill(Color.yellow.opacity(0.4))
                .frame(width: 500)
                .blur(radius: 100)
                .offset(y: 100)
        }
        .ignoresSafeArea()
    }
}

#Preview {
    NorthernMistBackground()
}
