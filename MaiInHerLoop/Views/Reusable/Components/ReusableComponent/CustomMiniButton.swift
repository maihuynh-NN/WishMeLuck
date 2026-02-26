//
//  CustomMiniButton.swift
//  MaiInHerLoop
//
//  Created by Huynh Ngoc Nhat Mai on 15/2/26.
//

import SwiftUI

struct CustomMiniButton: View {
    private let iconType: IconType
    let buttonColor: Color
    let action: () -> Void

    // MARK: - Icon variants
    private enum IconType {
        case asset(String)
        case sfSymbol(String)
    }

    // MARK: - Original asset-image initializer (unchanged)
    init(icon: String, buttonColor: Color, action: @escaping () -> Void) {
        self.iconType = .asset(icon)
        self.buttonColor = buttonColor
        self.action = action
    }

    // MARK: - New SF Symbol initializer
    init(systemIcon: String, buttonColor: Color, action: @escaping () -> Void) {
        self.iconType = .sfSymbol(systemIcon)
        self.buttonColor = buttonColor
        self.action = action
    }

    var body: some View {
        Button(action: action) {
            ZStack {
                switch iconType {
                case .asset(let name):
                    Image(name)
                        .resizable()
                        .scaledToFit()
                        .aspectRatio(contentMode: .fill)
                        .frame(width: 30, height: 30)
                        .clipped()
                        .scaleEffect(0.5)

                case .sfSymbol(let name):
                    Image(systemName: name)
                        .font(.system(.body).weight(.semibold))
                        .foregroundColor(buttonColor)
                }
            }
            .frame(width: 30, height: 30)
            .background(buttonColor.opacity(0.4))
        }
        .frame(minWidth: 44, minHeight: 44)   // HIG Rule 1: 44pt touch target
        .contentShape(Rectangle())
    }
}

// MARK: - Preview
#Preview {
    ZStack {
        LinearGradient(
            gradient: Gradient(colors: [Color("Moss"), Color("Red")]),
            startPoint: .topLeading,
            endPoint: .bottomTrailing
        )
        .edgesIgnoringSafeArea(.all)

        HStack(spacing: 20) {
            // Original asset icon
            CustomMiniButton(
                icon: "leaderboard",
                buttonColor: Color("Beige"),
                action: {}
            )
            .customedBorder(
                borderShape: "panel-border-004",
                borderColor: Color(.white),
                buttonType: .miniButton
            )

            // New SF Symbol icon
            CustomMiniButton(
                systemIcon: "gearshape.fill",
                buttonColor: Color("Beige"),
                action: {}
            )
            .customedBorder(
                borderShape: "panel-border-004",
                borderColor: Color(.white),
                buttonType: .miniButton
            )
        }
    }
}
