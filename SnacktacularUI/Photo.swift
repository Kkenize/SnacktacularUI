//
//  Photo.swift
//  SnacktacularUI
//
//  Created by Zhejun Zhang on 4/6/25.
//

import Foundation
import FirebaseFirestore
import FirebaseAuth

class Photo: Identifiable, Codable {
    @DocumentID var id: String?
    var imageURLString = "" //This will hold the URL for loading the image
    var description = ""
    var reviewer: String = Auth.auth().currentUser?.email ?? ""
    var postOn = Date() //current date/time
    
    init(id: String? = nil, imageURLString: String = "", description: String = "", reviewer: String = (Auth.auth().currentUser?.email ?? ""), postOn: Date = Date()) {
        self.id = id
        self.imageURLString = imageURLString
        self.description = description
        self.reviewer = reviewer
        self.postOn = postOn
    }
}

extension Photo {
    static var preview: Photo {
        let newPhoto = Photo(id: "1", imageURLString: "https://lh3.googleusercontent.com/gps-cs-s/AB5caB89NJtdW4IPfJ2hnk-SUfrgZ1vAcZP3TIIWm17dOb3uj_uQTFW_ytMS_qja5e5_T4UGhN4VuFBvDpxo6W2796jNahUul3EXnPwTel0cB5mO25NWiq2PKteGEdOhHESl2drvmHx9qg=s1360-w1360-h1020", description: "dorm building", reviewer: "reviewer@test.com", postOn: Date())
        return newPhoto
    }
}
