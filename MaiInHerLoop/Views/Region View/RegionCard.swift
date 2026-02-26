import SwiftUI

struct RegionCard: View {
    let region: Region
    
    // MARK: - Responsive
    @Environment(\.horizontalSizeClass) var horizontalSizeClass
    private var isWide: Bool { horizontalSizeClass == .regular }
    private var cardW: CGFloat { isWide ? 420 : 321 }
    private var cardH: CGFloat { isWide ? 630 : 482 }
    
    var body: some View {
        ZStack(alignment: .bottom){
            CustomCard(
                image: region.name,
                borderColor: Color("Gold2"),
                size: .customed(width: cardW, height: cardH)
            ) {
                LinearGradient(
                    colors: [Color.black.opacity(0.9), Color.clear],
                    startPoint: .bottom,
                    endPoint: .center
                )
                .clipShape(RoundedRectangle(cornerRadius: 20))
                .frame(width: cardW, height: cardH)
            }
            .scaledToFit()
            .modifier(ShadowModifier(color: Color("Gold2").opacity(0.5)))
            
            // Text overlay
            VStack(alignment: .center, spacing: 16) {
                VStack(spacing: 8) {
                    Text(region.name.uppercased())
                        .font(.title)
                        .fontWeight(.bold)
                        .multilineTextAlignment(.center)
                        .foregroundColor(.white)
                    
                    Text(region.story)
                        .font(.subheadline)
                        .multilineTextAlignment(.center)
                        .foregroundColor(.white.opacity(0.9))
                        .lineLimit(3)
                        .fixedSize(horizontal: false, vertical: true)
                    
                    Text("region.tap_to_explore".localized)
                        .font(.footnote)
                        .multilineTextAlignment(.center)
                        .foregroundColor(.white.opacity(0.7))
                        .padding(.top, 4)
                }
            }
            .padding(.horizontal, 24)
            .padding(.bottom, isWide ? 40 : 32)
        }
    }
}

#Preview {
    RegionSelectionView()
}
