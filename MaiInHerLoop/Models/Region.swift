import SwiftUI

let regions: [Region] = [
    Region(region_id: 1, name: "South", story: "Neon rivers and monsoon heat. The delta never sleeps."),
    Region(region_id: 2, name: "North", story: "Old mountains, deep valleys. The land remembers everything."),
    Region(region_id: 3, name: "Central", story: "Salt wind and stone towns. Between the sea and the sky.")
]

struct Region: Identifiable {
    let region_id: Int
    let name: String
    let story: String
    
    var id: Int { region_id }
}
