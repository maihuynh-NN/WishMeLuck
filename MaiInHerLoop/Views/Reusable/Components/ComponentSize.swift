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
    case customed(width: CGFloat, height: CGFloat) // flexible case
    
    var size: (width: CGFloat, height: CGFloat) {
        switch self {
        case .mainButton:
            return (150,50)
        case .miniButton:
            return (30,30)
        case .customed(width: let width, height: let height):
            return (width, height)
        }
    }
}
