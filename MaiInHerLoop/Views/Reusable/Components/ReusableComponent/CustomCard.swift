//
//  Buttons.swift
//  MaiInHerLoop
//
//  Created by Mai Huynh Ngoc Nhat on 12/2/26.
//

import SwiftUI

struct CustomCard<Content: View>: View {
    let image: String
    let borderColor: Color
    let size: ComponentSize
    let content: Content

    init(image: String, borderColor: Color, size: ComponentSize, @ViewBuilder content: () -> Content = { EmptyView() }) {
        self.image = image
        self.borderColor = borderColor
        self.size = size
        self.content = content()
    }

    var body: some View {
        let (width, height) = size.size

        ZStack {
            Image(image)
                .resizable()
                .scaledToFit()
                .aspectRatio(contentMode: .fill)
                .frame(width: width, height: height)
                .cornerRadius(12)
                .overlay(
                    RoundedRectangle(cornerRadius: 12)
                        .stroke(borderColor)
                )

            content
        }
    }
}

#Preview {
    ZStack {
        Image("MainBackground")
            .resizable()
            .scaledToFill()
            .aspectRatio(contentMode: .fill)
            .ignoresSafeArea(edges: .all)
        
        CustomCard(
            image: "Central",
            borderColor: Color("Moss"),
            size: .customed(width: 300, height: 500)
        )
        .modifier(ShadowModifier(color: Color("Moss")))
    }
}
