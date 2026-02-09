//
//  LanguageSelectionView.swift
//  MaiInHerLoop
//
//  Created by Mai Huynh Ngoc Nhat on 9/2/26.
//

import SwiftUI

struct LanguageSelectionView: View {
    @AppStorage("selectedLanguage") private var language = "en"
    @State private var navigateToStory = false
    
    var body: some View {
        VStack(spacing: 40) {
            Spacer()
            
            // App title/logo area
            VStack(spacing: 16) {
                Image(systemName: "globe")
                    .font(.system(size: 60))
                    .foregroundColor(.blue)
                
                Text("Mai In Her Loop")
                    .font(.largeTitle.bold())
                
                Text("Choose your language")
                    .font(.subheadline)
                    .foregroundColor(.secondary)
            }
            
            Spacer()
            
            // Language buttons
            VStack(spacing: 16) {
                Button {
                    language = "en"
                    navigateToStory = true
                } label: {
                    HStack {
                        Text("🇬🇧")
                            .font(.title)
                        Text("English")
                            .font(.title3)
                            .fontWeight(.semibold)
                    }
                    .frame(maxWidth: .infinity)
                    .padding()
                    .background(language == "en" ? Color.blue : Color.blue.opacity(0.15))
                    .foregroundColor(language == "en" ? .white : .blue)
                    .cornerRadius(12)
                }
                
                Button {
                    language = "vi"
                    navigateToStory = true
                } label: {
                    HStack {
                        Text("🇻🇳")
                            .font(.title)
                        Text("Tiếng Việt")
                            .font(.title3)
                            .fontWeight(.semibold)
                    }
                    .frame(maxWidth: .infinity)
                    .padding()
                    .background(language == "vi" ? Color.blue : Color.blue.opacity(0.15))
                    .foregroundColor(language == "vi" ? .white : .blue)
                    .cornerRadius(12)
                }
            }
            .padding(.horizontal, 40)
            
            Spacer()
        }
        .navigationDestination(isPresented: $navigateToStory) {
            Text("Story View (Coming in Task 3.3)")
        }
    }
}

#Preview {
    NavigationStack {
        LanguageSelectionView()
    }
}
