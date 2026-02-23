//
//  ComponentSize.swift
//  MaiInHerLoop
//
//  Created by Huynh Ngoc Nhat Mai on 15/2/26.
//
import SwiftUI

enum ComponentSize {
    case mainButton
    case miniButton
    case customed(width: CGFloat, height: CGFloat)
    case flexible(height: CGFloat)

    var size: (width: CGFloat, height: CGFloat) {
        let isIPad = UIDevice.current.userInterfaceIdiom == .pad
        switch self {
        case .mainButton:
            return isIPad ? (220, 60) : (150, 50)
        case .miniButton:
            return isIPad ? (44, 44) : (30, 30)  // 44pt = Apple HIG minimum tap target
        case .customed(let width, let height):
            return (width, height)
        case .flexible(let height):
            return (.infinity, height)
        }
    }

    var isFlexible: Bool {
        if case .flexible = self { return true }
        return false
    }
}
