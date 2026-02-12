//
//  OverlayModal.swift
//  MaiInHerLoop
//
//  Created by Mai Huynh Ngoc Nhat on 12/2/26.
//
import SwiftUI

struct OverlayAppearModifier: ViewModifier {
    @State private var opacity: Double = 0
    @State private var yOffset: CGFloat = -50
    
    func body(content: Content) -> some View {
        content
            .opacity(opacity)
            .offset(y: yOffset)
            .onAppear {
                withAnimation(AppAnimations.modalSlide) {
                    opacity = 1.0
                    yOffset = 0
                }
            }
    }
}

struct ModalSlideInModifier: ViewModifier {
    @State private var offset: CGFloat = 300
    
    func body(content: Content) -> some View {
        content
            .offset(y: offset)
            .onAppear {
                withAnimation(AppAnimations.modalSlide) {
                    offset = 0
                }
            }
    }
}

struct PanelExpandModifier: ViewModifier {
    @State private var scale: CGFloat = 0.8
    
    func body(content: Content) -> some View {
        content
            .scaleEffect(scale)
            .onAppear {
                withAnimation(AppAnimations.panelExpand) {
                    scale = 1.0
                }
            }
    }
}

struct OverlayDismissModifier: ViewModifier {
    @State private var opacity: Double = 1.0
    
    func body(content: Content) -> some View {
        content
            .opacity(opacity)
            .onDisappear {
                withAnimation(AppAnimations.overlayFade) {
                    opacity = 0
                }
            }
    }
}

extension View {

    func overlayAppear() -> some View {
        modifier(OverlayAppearModifier())
    }
    
    func overlayDismiss() -> some View {
        modifier(OverlayDismissModifier())
    }
    
    func modalSlideIn() -> some View {
        modifier(ModalSlideInModifier())
    }
    
    func panelExpand() -> some View {
        modifier(PanelExpandModifier())
    }
}


