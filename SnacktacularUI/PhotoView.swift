//
//  PhotoView.swift
//  SnacktacularUI
//
//  Created by Zhejun Zhang on 3/31/25.
//

import SwiftUI
import PhotosUI

struct PhotoView: View {
    @State var spot: Spot
    @State private var photo = Photo()
    @State private var data = Data() //we need this to take image and convert it to data to save in firestore Storage
    @State private var selectedPhoto: PhotosPickerItem?
    @State private var pickerIsPresented = true
    @State private var selectedImage = Image(systemName: "photo")
    @Environment(\.dismiss) private var dismiss
    
    var body: some View {
        NavigationStack {
            Spacer()
            
            selectedImage
                .resizable()
                .scaledToFit()
            
            Spacer()
            
            TextField("description", text: $photo.description)
                .textFieldStyle(.roundedBorder)
            
            Text("by: \(photo.reviewer), on: \(photo.postOn.formatted(date: .numeric, time: .omitted))")
            
                .toolbar {
                    ToolbarItem(placement: .topBarLeading) {
                        Button("Cancel") {
                            dismiss()
                        }
                    }
                    
                    ToolbarItem(placement: .topBarTrailing) {
                        Button("Save") {
                            Task {
                                await PhotoViewModel.saveImage(spot: spot, photo: photo, data: data)
                                dismiss()
                            }
                        }
                    }
                }
                .photosPicker(isPresented:$pickerIsPresented, selection: $selectedPhoto)
                .onChange(of: selectedPhoto) {
                    Task {
                        do {
                            if let image = try await selectedPhoto?.loadTransferable(type: Image.self){
                                selectedImage = image
                            }
                            
                            //get raw data from the image so we can save it to Firebase Storage
                            guard let transferredData = try await selectedPhoto?.loadTransferable(type: Data.self) else {
                                print("😡 ERROR: cannot convert data from selectedPhoto")
                                return
                            }
                            data = transferredData
                        } catch {
                            print("😡 ERROR: Could not create image from selectedPhoto. \(error.localizedDescription)")
                        }
                    }
                }
        }
        .padding()
    }
}

#Preview {
    PhotoView(spot: Spot())
}
