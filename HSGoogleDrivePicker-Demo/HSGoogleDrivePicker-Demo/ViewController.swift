//
//  ViewController.m
//  HSGoogleDrivePicker-Demo
//
//  Created by Rob Jonson on 14/08/2017.
//  Copyright © 2017 HobbyistSoftware. All rights reserved.
//

import HSGoogleDrivePicker
import UIKit


class ViewController: UIViewController, UINavigationBarDelegate {

    
    @IBOutlet weak var pickedFile: UILabel!
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view, typically from a nib.
    }
    
    func position(for bar: UIBarPositioning) -> UIBarPosition {
        return .topAttached
    }
    
    @IBAction func pickFile(_ sender: Any) {

        let picker = HSDrivePicker()
        picker.modalPresentationStyle = .fullScreen
        picker.view.backgroundColor = UIColor.white
        picker.visibleViewController?.navigationController?.navigationBar.tintColor = UIColor.black
        
       
       
        picker.pick(from: self) {
            (manager, file) in
            
            guard let fileName = file?.name else {
                print("No file picked")
                return
            }
            
            //update the label
            self.pickedFile.text = "selected: \(fileName)"
            
            //Download the file
            let destURL =  URL(fileURLWithPath: NSTemporaryDirectory()).appendingPathComponent(fileName)
            let destinationPath = destURL.path
            manager?.downloadFile(file, toPath: destinationPath, withCompletionHandler: { error in
                
                if error != nil {
                    print("Error downloading : \(error?.localizedDescription ?? "")")
                } else {
                    print("Success downloading to : \(destinationPath)")
                }
                
            })
        }
    }
}
