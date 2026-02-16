//
//  Untitled 3.swift
//  MaiInHerLoop
//
//  Created by Huynh Ngoc Nhat Mai on 15/2/26.
//

import SwiftUI

struct Region: Identifiable {
    let region_id: Int
    let name: String
    let story: String
    
    var id: Int { region_id }
}

#Preview {
    Text("Region model - no preview needed")
}
