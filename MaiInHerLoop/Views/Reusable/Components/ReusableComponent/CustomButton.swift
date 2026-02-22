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
                .frame(maxWidth: .infinity, maxHeight: .infinity)
                .background(buttonColor)
        }

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
            buttonType: .mainButton
        )
    }
}
