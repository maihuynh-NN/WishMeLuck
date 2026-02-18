//
//  MissionBriefingOverlay.swift
//  MaiInHerLoop
//
//  Created by Mai Huynh Ngoc Nhat on 18/2/26.
//

import SwiftUI

struct MissionBriefingOverlay: View {
    let scenario: Scenario
    let missionIndex: Int
    let onRespond: () -> Void
    let onRetreat: () -> Void

    @AppStorage("selectedLanguage") private var language = "en"
    @State private var pulseAnimation = false
    @State private var textOpacity = 0.0
    @State private var borderPulse = false
    @State private var showTypewriter = false
    @State private var navigateToGame = false

    private var title: String {
        language == "vi" ? scenario.titleVI : scenario.titleEN
    }
    private var intro: String {
        language == "vi" ? scenario.introVI : scenario.introEN
    }

    var body: some View {
        ZStack {
            // Dimmed background — no tap dismiss
            Color("Secondary3").opacity(0.6)
                .ignoresSafeArea(.all)

            CustomPanel(
                backgroundColor: Color.clear,
                size: .customed(width: 340, height: 480)
            ) {
                ZStack {
                    // Panel fill
                    RoundedRectangle(cornerRadius: 12)
                        .fill(Color("Background"))
                        .frame(width: 335, height: 475)

                    VStack(spacing: 0) {

                        // MARK: - Header
                        VStack(spacing: 8) {
                            HStack(spacing: 4) {
                                ForEach(0..<7, id: \.self) { _ in
                                    Rectangle()
                                        .fill(Color("Moss").opacity(0.7))
                                        .frame(width: 3, height: 12)
                                }
                            }
                            .opacity(textOpacity)
                            .padding(.top, 5)

                            Text("dispatch.incoming".lkey)
                                .font(.system(size: 18, weight: .black, design: .monospaced))
                                .foregroundColor(Color("Moss"))
                                .multilineTextAlignment(.center)
                                .tracking(1.5)
                                .opacity(pulseAnimation ? 1.0 : 0.8)
                                .padding(.horizontal, 10)

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
                            .padding(.horizontal, 60)
                        }
                        .padding(.top, 20)
                        .padding(.bottom, 16)

                        // MARK: - Mission number + reveal label
                        VStack(spacing: 6) {
                            HStack {
                                VStack(alignment: .leading, spacing: 4) {
                                    Text(String(format: "MISSION %02d", missionIndex + 1))
                                        .font(.system(size: 16, weight: .black, design: .monospaced))
                                        .foregroundColor(Color("Moss"))

                                    Text("dispatch.classified_revealed".lkey)
                                        .font(.system(size: 9, weight: .medium, design: .monospaced))
                                        .foregroundColor(Color("Moss").opacity(0.55))
                                        .tracking(0.5)
                                }

                                Spacer()

                                // Threat bar visual — 5 bars, all filled (disaster = max urgency)
                                HStack(spacing: 3) {
                                    ForEach(1...5, id: \.self) { _ in
                                        Rectangle()
                                            .fill(Color("Moss"))
                                            .frame(width: 10, height: 18)
                                            .scaleEffect(pulseAnimation ? 1.05 : 1.0)
                                    }
                                }
                            }
                            .padding(.horizontal, 25)
                            .padding(.bottom, 3)
                        }

                        // MARK: - Revealed title
                        VStack(alignment: .leading, spacing: 10) {
                            if showTypewriter {
                                Text("")
                                    .typewriter(title, speed: 0.045)
                                    .font(.system(size: 15, weight: .black, design: .monospaced))
                                    .foregroundColor(Color("Moss"))
                                    .lineLimit(2)
                                    .multilineTextAlignment(.leading)
                            }

                            // Intro scrollable box — same as StartGameOverlay context box
                            ScrollView {
                                VStack(alignment: .leading, spacing: 10) {
                                    if showTypewriter {
                                        Text("")
                                            .typewriter(intro, speed: 0.025)
                                            .font(.system(size: 11, weight: .medium))
                                            .foregroundColor(Color("Moss").opacity(0.8))
                                            .lineSpacing(3)
                                            .multilineTextAlignment(.leading)
                                    }
                                }
                                .padding(10)
                            }
                            .frame(height: 90)
                            .background(
                                RoundedRectangle(cornerRadius: 8)
                                    .fill(Color("Moss").opacity(0.06))
                                    .overlay(
                                        RoundedRectangle(cornerRadius: 8)
                                            .stroke(Color("Moss").opacity(borderPulse ? 0.5 : 0.25), lineWidth: 1.5)
                                    )
                            )
                        }
                        .padding(.horizontal, 20)
                        .padding(.bottom, 10)

                        Spacer(minLength: 12)

                        // MARK: - Actions
                        VStack(spacing: 12) {
                            NavigationLink(
                                destination: GameView(engine: ScenarioEngine(scenario: scenario)),
                                isActive: $navigateToGame
                            ) { EmptyView() }

                            CustomButton(
                                title: "dispatch.respond".lkey,
                                textColor: Color("Background"),
                                buttonColor: Color("Moss")
                            ) {
                                onRespond()
                                navigateToGame = true
                            }
                            .customedBorder(
                                borderShape: "panel-border-003",
                                borderColor: Color("Moss"),
                                buttonType: .mainButton
                            )
                            .scaleEffect(pulseAnimation ? 1.03 : 1.0)

                            VStack(spacing: 4) {
                                Text("dispatch.ready_prompt".lkey)
                                    .font(.system(size: 9, weight: .medium))
                                    .foregroundColor(Color("Moss").opacity(0.7))
                                    .italic()

                                Text("dispatch.decisions_await".lkey)
                                    .font(.system(size: 8, weight: .light))
                                    .foregroundColor(Color("Moss").opacity(0.5))
                            }
                            .opacity(textOpacity)

                            Button(action: onRetreat) {
                                Text("dispatch.not_ready".lkey)
                                    .font(.system(size: 11, weight: .light, design: .monospaced))
                                    .foregroundColor(Color("Moss").opacity(0.6))
                                    .tracking(0.5)
                                    .underline()
                            }
                        }
                        .padding(.top, 3)
                        .padding(.bottom, 20)
                    }
                    .padding(.horizontal, 15)

                    // MARK: - Corner decorations
                    VStack {
                        HStack {
                            cornerMark(top: true, left: true)
                            Spacer()
                            cornerMark(top: true, left: false)
                        }
                        Spacer()
                        HStack {
                            cornerMark(top: false, left: true)
                            Spacer()
                            cornerMark(top: false, left: false)
                        }
                    }
                    .padding(12)
                    .opacity(textOpacity)
                }
            }
            .customedBorder(
                borderShape: "Alternative",
                borderColor: Color("Moss"),
                buttonType: .customed(width: 340, height: 480)
            )
            .overlayAppear()
        }
        .onAppear {
            withAnimation(Animation.easeInOut(duration: 1.8).repeatForever(autoreverses: true)) {
                pulseAnimation = true
            }
            withAnimation(Animation.easeInOut(duration: 2.2).repeatForever(autoreverses: true).delay(0.3)) {
                borderPulse = true
            }
            withAnimation(.easeIn(duration: 1.0).delay(0.4)) {
                textOpacity = 1.0
            }
            DispatchQueue.main.asyncAfter(deadline: .now() + 0.6) {
                showTypewriter = true
            }
        }
    }

    // MARK: - Corner decoration (copied from StartGameOverlay/DifficultyOverlay)
    @ViewBuilder
    private func cornerMark(top: Bool, left: Bool) -> some View {
        VStack(spacing: 1) {
            if top {
                HStack(spacing: 1) {
                    if left {
                        Rectangle().fill(Color("Moss")).frame(width: 8, height: 1)
                        Rectangle().fill(Color("Moss").opacity(0.6)).frame(width: 4, height: 1)
                    } else {
                        Rectangle().fill(Color("Moss").opacity(0.6)).frame(width: 4, height: 1)
                        Rectangle().fill(Color("Moss")).frame(width: 8, height: 1)
                    }
                }
                HStack(spacing: 1) {
                    if left {
                        Rectangle().fill(Color("Moss").opacity(0.8)).frame(width: 1, height: 8)
                        Spacer()
                    } else {
                        Spacer()
                        Rectangle().fill(Color("Moss").opacity(0.8)).frame(width: 1, height: 8)
                    }
                }
            } else {
                HStack(spacing: 1) {
                    if left {
                        Rectangle().fill(Color("Moss").opacity(0.8)).frame(width: 1, height: 8)
                        Spacer()
                    } else {
                        Spacer()
                        Rectangle().fill(Color("Moss").opacity(0.8)).frame(width: 1, height: 8)
                    }
                }
                HStack(spacing: 1) {
                    if left {
                        Rectangle().fill(Color("Moss")).frame(width: 8, height: 1)
                        Rectangle().fill(Color("Moss").opacity(0.6)).frame(width: 4, height: 1)
                    } else {
                        Rectangle().fill(Color("Moss").opacity(0.6)).frame(width: 4, height: 1)
                        Rectangle().fill(Color("Moss")).frame(width: 8, height: 1)
                    }
                }
            }
        }
        .frame(width: 12, height: 12)
    }
}

#Preview {
    MissionBriefingOverlay(
        scenario: Scenario(
            id: "north_easy_1",
            region: "north",
            titleEN: "Flash Flood in Hanoi",
            titleVI: "Lũ Quét ở Hà Nội",
            introEN: "Heavy rain has been falling for 6 hours. The streets are rising. You are inside.",
            introVI: "Mưa lớn đã rơi suốt 6 giờ. Mặt đường đang dâng lên.",
            startQuestionID: "q1",
            questions: []
        ),
        missionIndex: 0,
        onRespond: {},
        onRetreat: {}
    )
}
