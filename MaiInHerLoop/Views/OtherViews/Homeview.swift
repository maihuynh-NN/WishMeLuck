//
//  HomeView.swift
//  MaiInHerLoop
//
//  Created by Huynh Ngoc Nhat Mai on 26/2/26.
//

import SwiftUI

struct HomeView: View {

    // MARK: - Persisted State
    @AppStorage("selectedLanguage") private var language = "en"

    // MARK: - Navigation State
    @State private var navigateToScenarioList = false
    @State private var navigateToRegion = false
    @State private var navigateToDiary = false

    // MARK: - Settings State
    @State private var showSettings = false

    // MARK: - Animation State
    @State private var showContent = false

    // MARK: - Environment
    @Environment(\.accessibilityReduceMotion) private var reduceMotion
    @Environment(\.dynamicTypeSize) private var typeSize

    // MARK: - Responsive
    private var isIPad: Bool { UIDevice.current.userInterfaceIdiom == .pad }
    private var buttonLeading: CGFloat { isIPad ? 50 : 24 }
    private var buttonSpacing: CGFloat { isIPad ? 18 : 15 }

    // MARK: - Body
    var body: some View {
        ZStack {
            // MARK: - Background
            backgroundLayer

            // MARK: - Title (top right)
            VStack {
                HStack {
                    Spacer()

                    if showContent {
                        titleSection
                            .staggeredAppear(delay: 0.0)
                    }
                }

                Spacer()
            }

            // MARK: - Buttons + Settings mini-button (bottom left)
            VStack {
                Spacer()

                HStack {
                    if showContent {
                        buttonStack
                    }

                    Spacer()
                }
                .padding(.bottom, isIPad ? 100 : 80)
            }
            .padding(.bottom, 34)               // HIG Rule 7: home indicator clearance

            // MARK: - Settings Modal Overlay
            if showSettings {
                SettingsModal(isPresented: $showSettings)
                    .transition(.opacity)
                    .zIndex(10)
            }

            // MARK: - Hidden NavigationLinks
            navigationDestinations
        }
        .navigationBarHidden(true)
        .onAppear {
            if reduceMotion {
                showContent = true
                return
            }
            DispatchQueue.main.asyncAfter(deadline: .now() + 0.3) {
                showContent = true
            }
        }
    }

    // MARK: - Background Layer
    private var backgroundLayer: some View {
        ZStack {
            Image("Homeview")
                .resizable()
                .scaledToFill()
                .frame(
                    width: UIScreen.main.bounds.width,
                    height: UIScreen.main.bounds.height
                )
                .clipped()
                .ignoresSafeArea()
                .accessibilityHidden(true)

  
            LinearGradient(
                stops: [
                    .init(color: Color.black.opacity(0.0),  location: 0.0),
                    .init(color: Color.black.opacity(0.05), location: 0.3),
                    .init(color: Color.black.opacity(0.3),  location: 0.65),
                    .init(color: Color.black.opacity(0.55), location: 1.0)
                ],
                startPoint: .top,
                endPoint: .bottom
            )
            .ignoresSafeArea()
            .accessibilityHidden(true)
        }
    }

    // MARK: - Title Section
    private var titleSection: some View {
        VStack(alignment: .trailing, spacing: 2) {
            Text("home.title.red".localized)
                .font(.system(.title2, design: .serif).weight(.bold))
                .foregroundColor(Color("Beige2"))
                .tracking(4)
                .shadow(color: Color.black.opacity(0.7), radius: 6)

            Text("home.title.embers".localized)
                .font(.system(.largeTitle, design: .serif).weight(.black))
                .foregroundColor(Color("Beige2"))
                .tracking(5)
                .shadow(color: Color.black.opacity(0.7), radius: 6)
                .minimumScaleFactor(typeSize >= .accessibility1 ? 0.7 : 1.0)

            Text("home.title.vi".localized)
                .font(.system(.caption, design: .serif).weight(.medium))
                .foregroundColor(Color("Beige2"))
                .tracking(2)
                .shadow(color: Color.black.opacity(0.5), radius: 4)
                .padding(.top, 2)
        }
        .padding(.trailing, isIPad ? 50 : 28)
        .padding(.top, isIPad ? 135 : 120)
        .accessibilityElement(children: .combine)
        .accessibilityAddTraits(.isHeader)
        .accessibilityLabel("home.title.a11y".localized)
    }

    // MARK: - Button Stack
    private var buttonStack: some View {
        VStack(alignment: .leading, spacing: buttonSpacing) {

            homeButton(
                title: "home.start_game".localized,
                textColor: Color("Beige2"),
                buttonColor: Color("Red3"),
                borderColor: Color("Gold3"),
                rotation: -3,
                staggerDelay: 0.2
            ) {
                navigateToScenarioList = true
            }

            // Button 2: Visit Regions
            homeButton(
                title: "home.visit_regions".localized,
                textColor: Color("Beige2"),
                buttonColor: Color("Moss").opacity(0.75),
                borderColor: Color("Gold").opacity(0.6),
                rotation: 1.5,
                staggerDelay: 0.4
            ) {
                navigateToRegion = true
            }

            // Button 3: Diary
            homeButton(
                title: "home.diary".localized,
                textColor: Color("Beige2"),
                buttonColor: Color("Red3"),
                borderColor: Color("Gold3"),
                rotation: -2,
                staggerDelay: 0.6
            ) {
                navigateToDiary = true
            }

            // MARK: - Settings mini-button (below the 3 main buttons)
            CustomMiniButton(
                systemIcon: "gearshape.fill",
                buttonColor: Color("Beige2"),
                action: {
                    if reduceMotion {
                        showSettings = true
                        return
                    }
                    withAnimation(AppAnimations.overlayFade) {
                        showSettings = true
                    }
                }
            )
            .customedBorder(
                borderShape: "panel-border-004",
                borderColor: Color("Beige2").opacity(0.6),
                buttonType: .miniButton
            )
            .modifier(ShadowModifier(color: Color.black.opacity(0.3)))
            .rotationEffect(.degrees(2))
            .staggeredAppear(delay: 0.8)
            .padding(.top, 5)
            .accessibilityLabel("settings.button".localized)
            .accessibilityHint("settings.button.hint".localized)
        }
        .padding(.leading, buttonLeading)
    }

    // MARK: - Single Home Button
    private func homeButton(
        title: String,
        textColor: Color,
        buttonColor: Color,
        borderColor: Color,
        rotation: Double,
        staggerDelay: Double,
        action: @escaping () -> Void
    ) -> some View {
        CustomButton(
            title: title,
            textColor: textColor,
            buttonColor: buttonColor
        ) {
            action()
        }
        .customedBorder(
            borderShape: "panel-border-005",
            borderColor: borderColor,
            buttonType: .mainButton
        )
        .modifier(ShadowModifier(color: Color.black.opacity(0.35)))
        .rotationEffect(.degrees(rotation))
        .staggeredAppear(delay: staggerDelay)
    }

    // MARK: - Navigation Destinations
    @ViewBuilder
    private var navigationDestinations: some View {
        NavigationLink(
            destination: RegionSelectionView(),
            isActive: $navigateToScenarioList
        ) { EmptyView() }
            .hidden()

        NavigationLink(
            destination: RegionSelectionView(),
            isActive: $navigateToRegion
        ) { EmptyView() }
            .hidden()

        NavigationLink(
            destination: DiaryListView(),
            isActive: $navigateToDiary
        ) { EmptyView() }
            .hidden()
    }
}

// MARK: - Preview
#Preview("Home — iPhone") {
    NavigationStack {
        HomeView()
    }
}

#Preview("Home — iPad") {
    NavigationStack {
        HomeView()
    }
    .previewDevice("iPad Pro (12.9-inch) (6th generation)")
}
