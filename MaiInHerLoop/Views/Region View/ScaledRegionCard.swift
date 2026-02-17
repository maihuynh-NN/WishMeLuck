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
        .frame(width: 321, height: 481)
        .tag(index)
    }
}
