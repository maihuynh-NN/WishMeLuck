import SwiftUI

struct NorthernMistBackground: View {
    var body: some View {
        ZStack {
            LinearGradient(
                colors: [
                    Color("Moss"),
                    Color("Beige2").opacity(0.4)
                ],
                startPoint: .top,
                endPoint: .bottom
            )

            Circle()
                .fill(Color("Moss").opacity(0.4))
                .frame(width: 500)
                .blur(radius: 120)
                .offset(x: -80, y: -180)

            Circle()
                .fill(Color("Gold3").opacity(0.5))
                .frame(width: 600)
                .blur(radius: 140)
                .offset(x: 120, y: 200)
        }
        .ignoresSafeArea()
    }
}

#Preview {
    NorthernMistBackground()
}
