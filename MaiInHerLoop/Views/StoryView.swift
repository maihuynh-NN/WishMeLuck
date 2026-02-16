//
//  StoryView.swift
//  MaiInHerLoop
//
//  Created by Mai Huynh Ngoc Nhat on 9/2/26.
//

import SwiftUI

struct StoryView: View {
    @AppStorage("selectedLanguage") private var language = "en"
    @State private var navigateToRegion = false
    
    var body: some View {
        VStack(spacing: 32) {
            Spacer()
            
            // Story icon
            Image(systemName: "cloud.rain.fill")
                .font(.system(size: 60))
                .foregroundColor(.blue)
            
            // Story content
            VStack(alignment: .leading, spacing: 20) {
                Text(storyTitle)
                    .font(.title.bold())
                    .multilineTextAlignment(.center)
                    .frame(maxWidth: .infinity)
                
                Text(storyText)
                    .font(.body)
                    .foregroundColor(.primary)
                    .lineSpacing(6)
                    .multilineTextAlignment(.leading)
            }
            .padding(.horizontal, 24)
            
            Spacer()
            
            // Continue button
            Button {
                navigateToRegion = true
            } label: {
                Text(continueButtonText)
                    .font(.headline)
                    .foregroundColor(.white)
                    .frame(maxWidth: .infinity)
                    .padding()
                    .background(Color.blue)
                    .cornerRadius(12)
            }
            .padding(.horizontal, 40)
            .padding(.bottom, 40)
        }
        .navigationBarBackButtonHidden(true)
        .navigationDestination(isPresented: $navigateToRegion) {
            RegionSelectionView()
        }
    }
    
    // MARK: - Localized Content
    
    private var storyTitle: String {
        language == "vi"
        ? "Thiên Tai ở Việt Nam"
        : "Disasters in Vietnam"
    }
    
    private var storyText: String {
        language == "vi"
        ? """
        Việt Nam đối mặt với nhiều thiên tai khác nhau từ Bắc vào Nam. Lũ lụt ở miền Bắc, bão ở miền Trung, và hạn hán ở miền Nam đều đòi hỏi những phản ứng khác nhau.
        
        Trong trò chơi này, bạn sẽ trải nghiệm các tình huống khẩn cấp và khám phá cách bạn phản ứng dưới áp lực. Không có câu trả lời đúng hay sai - chỉ có những lựa chọn phản ánh bạn là ai.
        """
        : """
        Vietnam faces diverse disasters from North to South. Floods in the North, typhoons in the Central region, and droughts in the South each demand different responses.
        
        In this experience, you'll face emergency scenarios and discover how you respond under pressure. There are no right or wrong answers - only choices that reflect who you are.
        """
    }
    
    private var continueButtonText: String {
        language == "vi" ? "Tiếp Tục" : "Continue"
    }
}

#Preview("English") {
    NavigationStack {
        StoryView()
    }
}

#Preview("Vietnamese") {
    NavigationStack {
        StoryView()
            .onAppear {
                UserDefaults.standard.set("vi", forKey: "selectedLanguage")
            }
    }
}
