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
    var imageView: UIImageView!
    
    let imagePicker = UIImagePickerController()
    @State private var showingAlertSheet = false
    
    
    // MARK: Body
    
    var body: some View {
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
    
    
    struct ContentView_Previews: PreviewProvider {
        static var previews: some View {
            ContentView()
        }
    }
}

    // MARK: image picker



/*
class ViewController: UIViewController, UIImagePickerControllerDelegate, UINavigationControllerDelegate {
    
    // picker for photo
    @objc
    func promptPhoto() {
        
        let prompt = UIAlertController(title: "Choose a Photo",
                                       message: "Please choose a photo.",
                                       preferredStyle: .actionSheet)
        
        let imagePicker = UIImagePickerController()
        imagePicker.delegate = self
        
        func presentCamera(_ _: UIAlertAction) {
            imagePicker.sourceType = .camera
            self.present(imagePicker, animated: true)
        }
        
        let cameraAction = UIAlertAction(title: "Camera",
                                         style: .default,
                                         handler: presentCamera)
        
        func presentLibrary(_ _: UIAlertAction) {
            imagePicker.sourceType = .photoLibrary
            self.present(imagePicker, animated: true)
        }
        
        let libraryAction = UIAlertAction(title: "Photo Library",
                                          style: .default,
                                          handler: presentLibrary)
        
        func presentAlbums(_ _: UIAlertAction) {
            imagePicker.sourceType = .savedPhotosAlbum
            self.present(imagePicker, animated: true)
        }
        
        let albumsAction = UIAlertAction(title: "Saved Albums",
                                         style: .default,
                                         handler: presentAlbums)
        
        let cancelAction = UIAlertAction(title: "Cancel",
                                         style: .cancel,
                                         handler: nil)
        
        prompt.addAction(cameraAction)
        prompt.addAction(libraryAction)
        prompt.addAction(albumsAction)
        prompt.addAction(cancelAction)
        
        self.present(prompt, animated: true, completion: nil)
    }
 */
// }
