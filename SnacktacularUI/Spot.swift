//
//  Spot.swift
//  SnacktacularUI
//
//  Created by Zhejun Zhang on 3/31/25.
//

import Foundation
import FirebaseFirestore

struct Spot: Identifiable, Codable {
    @DocumentID var id: String?
    var name = ""
    var address = ""
}

extension Spot {
    static var preview: Spot {
        let newSpot = Spot(id: "1", name: "Boston Airport", address: "Boston, MA")
        return newSpot
    }
}
