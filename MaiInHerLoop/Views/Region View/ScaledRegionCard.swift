//
//  ScaledRegionCard.swift
//  MaiInHerLoop
//
//  Created by Huynh Ngoc Nhat Mai on 16/2/26.
//

import SwiftUI

struct ScaledRegionCard: View {
    let region: Region
    let index: Int
    @Binding var selectedRegion: Region?
    
    // MARK: - Responsive
    @Environment(\.horizontalSizeClass) var horizontalSizeClass
    private var isWide: Bool { horizontalSizeClass == .regular }
    private var cardWidth: CGFloat { isWide ? 420 : 321 }
    private var cardHeight: CGFloat { isWide ? 630 : 481 }
    
    var body: some View {
        GeometryReader { geo in
            let midX = geo.frame(in: .global).midX
            let screenMidX = UIScreen.main.bounds.width / 2
            let distance = abs(screenMidX - midX)
            let scale = max(0.85, 1 - (distance / screenMidX) * 0.15)
            let opacity = max(0.6, 1 - (distance / screenMidX) * 0.4)
            
            RegionCard(region: region)
                .scaleEffect(scale)
                .opacity(opacity)
                .onTapGesture {
                    selectedRegion = region
                }
        }
        .frame(width: cardWidth, height: cardHeight)
        .tag(index)
    }
}
