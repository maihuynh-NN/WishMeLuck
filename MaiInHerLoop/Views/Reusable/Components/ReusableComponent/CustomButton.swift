//
//  CustomButton.swift
//  MaiInHerLoop
//
//  Created by Huynh Ngoc Nhat Mai on 15/2/26.
//
import SwiftUI

struct CustomButton: View {
    let title: LocalizedStringKey
    let textColor: Color
    let buttonColor: Color
    let action: () -> Void
    
    var body: some View {
        Button(action: action) {
            Text(title)
                .foregroundStyle(textColor)
                .frame(width: 155, height: 55)
                .background(
                    buttonColor
                )
        }
        .padding(.horizontal, 40)

    }
}
    
#Preview {
    ZStack {
        NorthernMistBackground()
        CustomButton(
            title: "How To Play",
            textColor: Color("Beige"),
            buttonColor: Color("Red"),
            action: {}
        )
        .customedBorder(
            borderShape: "panel-border-003",
            borderColor: Color("Gold3"),
            buttonType: .mainButton)
        
    }
}

