//
//  ImagePicker.swift
//  DetectTest
//
//  Created by Kovs on 30.05.2021.
//

import SwiftUI

struct ImagePicker: UIViewControllerRepresentable {
    
    func updateUIViewController(_ uiViewController: UIImagePickerController, context: Context) {
        // code
    }
    
    // a view that respresents a UIKit controller:
    
    func makeUIViewController(context: UIViewControllerRepresentableContext<ImagePicker>) -> UIImagePickerController {
        
        let picker = UIImagePickerController()
        return picker
        
    }
    
}
