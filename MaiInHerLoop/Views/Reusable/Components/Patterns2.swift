//
//  Patterns2.swift
//  MaiInHerLoop
//
//  Created by Mai Huynh Ngoc Nhat on 12/2/26.
//
import SwiftUI

struct AppPattern: View {
    var body: some View {
        VStack(spacing: 20) {  // ADD THIS
            HStack {
                Rectangle()
                    .fill(Color("Moss").opacity(0.6))
                    .frame(height: 1)
                
                Text("◆")
                    .font(.system(size: 8))
                    .foregroundColor(Color("Moss"))
                
                Rectangle()
                    .fill(Color("Moss").opacity(0.6))
                    .frame(height: 1)
            }
            .padding(.horizontal, 50)
            
            HStack(spacing: 6) {
                ForEach(0..<9, id: \.self) { _ in
                    Circle()
                        .fill(Color("Moss").opacity(0.6))
                        .frame(width: 3, height: 3)
                }
            }
            
            HStack(spacing: 4) {
                ForEach(0..<7, id: \.self) { _ in
                    Rectangle()
                        .fill(Color("Moss").opacity(0.7))
                        .frame(width: 3, height: 12)
                }
            }
            .padding(.top, 5)
            
            HStack {
                Rectangle()
                    .fill(Color("Moss").opacity(0.6))
                    .frame(height: 1)
                
                Text("∎")
                    .font(.system(size: 8))
                    .foregroundColor(Color("Moss"))
                
                Rectangle()
                    .fill(Color("Moss").opacity(0.6))
                    .frame(height: 1)
            }
            
            HStack(spacing: 2) {
                ForEach(0..<10, id: \.self) { _ in
                    Image(systemName: "chevron.right")
                        .font(.system(size: 8, weight: .bold))
                        .foregroundColor(Color("Moss"))
                }
            }

            HStack(spacing: 2) {
                ForEach(0..<6, id: \.self) { i in
                    Rectangle()
                        .fill(Color("Moss").opacity(0.7))
                        .frame(width: 6, height: CGFloat(6 + i * 2))
                }
            }
        }  // ADD THIS
        .padding()  // ADD THIS
    }
}
#Preview {
    AppPattern()
}

