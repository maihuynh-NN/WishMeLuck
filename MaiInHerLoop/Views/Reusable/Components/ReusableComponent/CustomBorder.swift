/*
  RMIT University Vietnam
  Course: COSC3062|COSC3063 iPhone Software Engineering
  Semester: 2025B
  Assessment: Assignment 2
  Author: Huynh Ngoc Nhat Mai
  ID: s3926881
  Created  date: 25/08/2025
  Last modified: 10/09/2025
  Acknowledgement: We Acknowledging in README.md
*/

import SwiftUI

struct CustomedBorder: ViewModifier {
    let borderShape: String
    let borderColor: Color
    let buttonType: ComponentSize
    
    func body(content: Content) -> some View {
        let (width, height) = buttonType.size

        ZStack {
            Image(borderShape)
                .resizable(
                    capInsets: EdgeInsets(
                        top: 8,
                        leading: 8,
                        bottom: 8,
                        trailing: 8),
                    resizingMode: .stretch
                )
                .renderingMode(.template)
                .foregroundStyle(borderColor).opacity(0.4)
                .frame(width: width, height: height)
             
            content
        }
    }
}

extension View {
    func customedBorder(borderShape: String, borderColor: Color, buttonType: ComponentSize) -> some View {
        self.modifier(CustomedBorder(
            borderShape: borderShape,
            borderColor: borderColor,
            buttonType: buttonType))
    }
}

#Preview {
    CustomPanel(
        backgroundColor: Color(.white),
        size: .customed(width: 300, height: 500)
    ) {
        VStack {
            Text("Profile")
        }
    }
        .customedBorder(
            borderShape: "panel-border-003",
            borderColor: Color("Moss"),
            buttonType: .customed(width: 300, height: 500)
        )
}
