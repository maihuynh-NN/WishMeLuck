import SwiftUI

let regions: [Region] = [
    Region(region_id: 1, name: "South", story: "Fertile delta lands where monsoons bring both blessing and devastation."),
    Region(region_id: 2, name: "North", story: "Ancient mountains harbor storms that test the wisdom of ancestors."),
    Region(region_id: 3, name: "Central", story: "Coastal highlands where typhoons write their chronicles in stone.")
]

struct Region: Identifiable {
    let region_id: Int
    let name: String
    let story: String
    
    var id: Int { region_id }
}

#Preview {
    Text("Region model - no preview needed")
}
