//
//  CustomMiniButton.swift
//  MaiInHerLoop
//
//  Created by Huynh Ngoc Nhat Mai on 15/2/26.
//

import SwiftUI

struct CustomMiniButton: View {
    let icon: String
    let buttonColor: Color
    let action: () -> Void
    
    var body: some View {
        Button(action: action) {
            ZStack{
                Image(icon)
                    .resizable()
                    .scaledToFit()
                    .aspectRatio(contentMode: .fill)
                    .frame(width: 30, height: 30)
                    .clipped()
                    .scaleEffect(0.5)
                    .background(buttonColor.opacity(0.4))
            }
        }
    }
}

#Preview {
    ZStack {
        LinearGradient(gradient:
                        Gradient(colors: [Color("Moss"), Color("Red")]),
                       startPoint: .topLeading,
                       endPoint: .bottomTrailing
        )
        .edgesIgnoringSafeArea(.all)
        
        CustomMiniButton(
            icon: "leaderboard",
            buttonColor: Color("Beige"),
            action: {})
        //.modifier(ShadowModifier(color: Color(.white)))
        .customedBorder(borderShape: "panel-border-004", borderColor: Color(.white), buttonType: .miniButton)
    }
}
