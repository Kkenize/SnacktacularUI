//
//  PhotoViewModel.swift
//  SnacktacularUI
//
//  Created by Zhejun Zhang on 4/6/25.
//

import Foundation
import Firebase
import FirebaseAuth
import FirebaseStorage
import SwiftUI

class PhotoViewModel {
    
    
    static func saveImage(spot: Spot, photo: Photo, data: Data) async {
        guard let id = spot.id else {
            print("😡 Error: should not have been called without a valid spot.id")
            return
        }
        
        let storage = Storage.storage().reference()
        let metadata = StorageMetadata()
        if photo.id == nil {
            photo.id = UUID().uuidString
        }
        metadata.contentType = "image/jpeg" //allow image to be view in the browser from the Firebase console
        let path = "\(id)/\(photo.id ?? "n/a")"
        
        do {
            let storageref = storage.child(path)
            let returnedMetaData = try await storageref.putDataAsync(data, metadata: metadata)
            print("😎 Saved! \(returnedMetaData)")
            
            //get URL to load the image
            guard let url = try? await storageref.downloadURL() else {
                print("😡 ERROR: could not get downloadURL")
                return
            }
            photo.imageURLString = url.absoluteString
            print("photo.imageURLString: \(photo.imageURLString)")
            
            //now the photo is saved to storage, we are saving a photo document to the spot.id's "photos" collection
            let db = Firestore.firestore()
            do {
                try db.collection("spots").document(id).collection("photos").document(photo.id ?? "n/a").setData(from: photo)
            } catch {
                print("😡 ERROR: could not update data in spots/\(id)/photos/\(photo.id ?? "n/a").\(error.localizedDescription)")
            }
        } catch {
            print("😡 Error saving photo to Storage \(error.localizedDescription)")
        }
    }
}
