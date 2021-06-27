//
//  ImagePicker.swift
//  DetectTest
//
//  Created by Kovs on 30.05.2021.
//

import UIKit
import SwiftUI
import Vision

struct ImagePicker: UIViewControllerRepresentable {
    
    
    @Binding var image: UIImage?
    @Environment(\.presentationMode) var presentationMode
    
    var sourceType: UIImagePickerController.SourceType
    
    func updateUIViewController(_ uiViewController: UIImagePickerController, context: Context) {
        // code
    }
    
    // a view that respresents a UIKit controller:
    func makeUIViewController(context: UIViewControllerRepresentableContext<ImagePicker>) -> UIImagePickerController {
        
        let picker = UIImagePickerController()
        picker.sourceType = self.sourceType
        picker.delegate = context.coordinator
        return picker
        
    }
    
    func makeCoordinator() -> Coordinator {
        Coordinator(self)
    }
    
    class Coordinator: NSObject, UIImagePickerControllerDelegate, UINavigationControllerDelegate {
        var parent: ImagePicker
        
        init(_ parent: ImagePicker) {
            self.parent = parent
        }
        
        func imagePickerController(_ picker: UIImagePickerController, didFinishPickingMediaWithInfo info: [UIImagePickerController.InfoKey : Any]) {
            
            if let uiImage = info[.originalImage] as? UIImage {
                parent.image = uiImage
            }
            
            guard let cgImage = parent.image?.cgImage else {
                return
            }
            
            performVisionRequest(image: cgImage)
            
            parent.presentationMode.wrappedValue.dismiss()
        }
    }
    
}
    
    // MARK: - Vision
    
    /// - Tag: PerformRequests
    
    // Request the search
    var textDetectionRequest: VNDetectTextRectanglesRequest = {
        let textDetectRequest = VNDetectTextRectanglesRequest(completionHandler: handleDetectedText)
        // Tell Vision to report bounding box around each character.
        textDetectRequest.reportCharacterBoxes = true
        return textDetectRequest
    }()
    
    
    // Finding text

    fileprivate func handleDetectedText(request: VNRequest?, error: Error?) {
        if let nsError = error as NSError? {
            presentAlert("Text Detection Error", error: nsError)
            return
        }
        DispatchQueue.main.async {
            let results = request?.results as? [VNTextObservation]
        }
    }
        
        func presentAlert(_ title: String, error: NSError) {
            // Always present alert on main thread.
            DispatchQueue.main.async {
                let alertController = UIAlertController(title: title,
                                                        message: error.localizedDescription,
                                                        preferredStyle: .alert)
                let okAction = UIAlertAction(title: "OK",
                                             style: .default) { _ in
                    // Do nothing -- simply dismiss alert.
                }
                alertController.addAction(okAction)
            }
        }
        
        func performVisionRequest(image: CGImage) {
            
            // Fetch desired requests based on switch status.
            let requests = createVisionRequests()
            // Create a request handler.
            let imageRequestHandler = VNImageRequestHandler(cgImage: image,
                                                            options: [:])
            
            // Send the requests to the request handler.
            DispatchQueue.global(qos: .userInitiated).async {
                do {
                    try imageRequestHandler.perform(requests)
                } catch let error as NSError {
                    print("Failed to perform image request: \(error)")
                    presentAlert("Image Request Failed", error: error)
                    return
                }
            }
        }
        
        func createVisionRequests() -> [VNRequest] {
            
            var requests: [VNRequest] = []
            requests.append(textDetectionRequest)
            
            return requests
        }


