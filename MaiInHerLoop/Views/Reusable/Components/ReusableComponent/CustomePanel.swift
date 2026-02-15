//
//  CustomePanel.swift
//  MaiInHerLoop
//
//  Created by Huynh Ngoc Nhat Mai on 15/2/26.
//


import SwiftUI

struct CustomPanel<Content: View>: View {
    let backgroundColor: Color
    let size: ComponentSize
    let content: () -> Content
    
    var body: some View {
        let (width, height) = size.size
        
        ZStack {
            content()
        }
        .frame(width: width, height: height)
        .background(backgroundColor.opacity(0.4))
    }
}

#Preview {
    CustomPanel(
        backgroundColor: Color("Moss"),
        size: .customed(width: 300, height: 500)
    ) {
        VStack {
            Text("Profile")
        }
    }
        .customedBorder(borderShape: "panle-border-003", borderColor: Color("Moss"), buttonType: .customed(width: 300, height: 500))
}
