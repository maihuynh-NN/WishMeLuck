//
//  LocalizabledStrings.swift
//  MaiInHerLoop
//
//  Created by Huynh Ngoc Nhat Mai on 16/2/26.
//
import Foundation
import SwiftUI

extension String {
    var localized: String {
        let language = UserDefaults.standard.string(forKey: "selectedLanguage") ?? "en"
        guard let path = Bundle.main.path(forResource: language, ofType: "lproj"),
              let bundle = Bundle(path: path) else {
            return NSLocalizedString(self, comment: "")
        }
        return NSLocalizedString(self, bundle: bundle, comment: "")
    }
    
    var lkey: LocalizedStringKey {
        LocalizedStringKey(self)
    }
}
