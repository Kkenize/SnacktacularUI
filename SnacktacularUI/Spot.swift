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
