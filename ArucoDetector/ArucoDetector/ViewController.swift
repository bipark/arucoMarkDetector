//
//  ViewController.swift
//  ArucoDetector
//
//  Created by Park Billy on 2019/12/19.
//  Copyright © 2019 Park Billy. All rights reserved.
//

import UIKit

class ViewController: UIViewController, UINavigationControllerDelegate, UIImagePickerControllerDelegate, UIScrollViewDelegate {

    @IBOutlet weak var scrollView: UIScrollView!
    @IBOutlet weak var imageView: UIImageView!
    
    var deviceID = UIDevice.current.identifierForVendor?.uuidString
    
    override func viewDidLoad() {
        super.viewDidLoad()
        #if DEBUG
            print("\(MarkDetector.openCVVersionString())")
            print(self.deviceID!)
        #endif
        
        self.scrollView.minimumZoomScale = 1.0
        self.scrollView.maximumZoomScale = 10.0
        self.scrollView.delegate = self

    }

    public func viewForZooming(in scrollView: UIScrollView) -> UIView? {
        return self.imageView
    }

    func imagePickerController(_ picker: UIImagePickerController, didFinishPickingMediaWithInfo info: [UIImagePickerController.InfoKey : Any]) {
        picker.dismiss(animated: true)

        self.scrollView.zoomScale = 1.0
        guard let image = info[.originalImage] as? UIImage else {
            print("No image found")
            return
        }
        let resized = UIImage.scale(image: image, by: 0.5)
        let retVal = MarkDetector.findMark(resized!)
        print(retVal)
        
        if (retVal["process"] as! Int == 0) {
            self.imageView.image = (retVal["image"] as? UIImage)!
        } else {
            let alert = UIAlertController(title: "Alert", message: "No ArUco Mark on image!!", preferredStyle:.alert)
            alert.addAction(UIAlertAction(title: "OK", style: .default))
            self.present(alert, animated: true)
        }


    }

    @IBAction func cameraAction(_ sender: Any) {
        let vc = UIImagePickerController()
        vc.sourceType = .camera
        vc.delegate = self
        present(vc, animated: true)
    }
    
    @IBAction func albumAction(_ sender: Any) {
        let vc = UIImagePickerController()
        vc.sourceType = .photoLibrary
        vc.delegate = self
        present(vc, animated: true)
    }
}

