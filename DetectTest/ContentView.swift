//
//  ContentView.swift
//  DetectTest
//
//  Created by Kovs on 18.05.2021.
//

import SwiftUI
import Vision
import UIKit

struct ContentView: View {
    
    // var viewController: ViewController?
    var preferredStatusBarStyle: UIStatusBarStyle { return .lightContent }
    // var imageView: UIImageView!
    @State private var image: Image?
    
    let imagePicker = UIImagePickerController()
    @State private var showingAlertSheet = false
    @State private var showImagePicker = false
    
    // MARK: Body
    
    var body: some View {
        
        VStack {
            
            image?
                .resizable()
                .scaledToFit()
            
            Image(systemName: "rectangle.stack")
                .font(.system(size: 25))
                .onTapGesture {
                    self.showingAlertSheet = true
                }
                .actionSheet(isPresented: $showingAlertSheet) {
                    ActionSheet(title: Text("Choose a photo"),
                                message: Text("Please choose a photo"),
                                buttons: [
                                    .default(Text("Camera")) { func presentCamera(_ _: UIAlertAction) {
                                        imagePicker.sourceType = .camera
                                        // init(imagePicker, animated: true)
                                    } },
                                    
                                    .default(Text("Photo Library")) { func presentLibrary(_ _: UIAlertAction) {
                                        imagePicker.sourceType = .photoLibrary
                                        // self.present(imagePicker, animated: true)
                                    } },
                                    
                                    .default(Text("Saved Albums")) { func presentAlbums(_ _: UIAlertAction) {
                                        imagePicker.sourceType = .savedPhotosAlbum
                                        // self.present(imagePicker, animated: true)
                                    } },
                                    
                                    .cancel()
                                ])
                    // end of actionSheet
                }
            
            
            
        }
        // end of VStack
        
        
        
    }
    
    
    struct ContentView_Previews: PreviewProvider {
        static var previews: some View {
            ContentView()
        }
    }
}

