//
//  RegionCard.swift
//  MaiInHerLoop
//
//  Created by Huynh Ngoc Nhat Mai on 16/2/26.
//

import SwiftUI

struct RegionCard: View {
    let region: Region
    
    var body: some View {
        ZStack(alignment: .bottom){
            CustomCard(
                image: region.name,
                borderColor: Color("Moss"),
                size: .customed(width: 321, height: 482)
            ) {
                LinearGradient(
                    colors: [Color.black.opacity(0.9), Color.clear],
                    startPoint: .bottom,
                    endPoint: .center
                )
                .clipShape(RoundedRectangle(cornerRadius: 20))
                .frame(width: 321, height: 482)
            }
            .scaledToFit()
            .modifier(ShadowModifier(color: Color("Moss").opacity(0.3)))
            
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
                    
                    Text("Tap to explore ›")
                        .font(.footnote)
                        .multilineTextAlignment(.center)
                        .foregroundColor(.white.opacity(0.7))
                        .padding(.top, 4)
                }
            }
            .padding(.horizontal, 24)
            .padding(.bottom, 32)
        }
    }
}

#Preview {
    RegionSelectionView()
}
