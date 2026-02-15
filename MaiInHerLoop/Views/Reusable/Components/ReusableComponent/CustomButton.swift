//
//  CustomButton.swift
//  MaiInHerLoop
//
//  Created by Huynh Ngoc Nhat Mai on 15/2/26.
//
import SwiftUI

struct CustomButton: View {
    let title: String
    let textColor: Color
    let buttonColor: Color
    let action: () -> Void
    
    var body: some View {
        Button(action: action) {
            Text(title)
                .foregroundStyle(textColor)
                .frame(width: 150, height: 50)
                .background(buttonColor.opacity(0.5))
        }
        .background(buttonColor.opacity(0.5))
        .padding(.horizontal, 40)
    }
}
    
    #Preview {
        CustomButton(
            title: "How To Play",
            textColor: Color(.black),
            buttonColor: Color(.white),
            action: {}
        )
        .customedBorder(
            borderShape: "panel-border-003",
            borderColor: Color("Moss"),
            buttonType: .mainButton)

    }

