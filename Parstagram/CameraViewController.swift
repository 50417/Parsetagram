//
//  CameraViewController.swift
//  Parstagram
//
//  Created by Pratistha Shrestha on 10/9/21.
//

import UIKit
import AlamofireImage
import Parse
class CameraViewController: UIViewController,UIImagePickerControllerDelegate, UINavigationControllerDelegate {

    @IBOutlet weak var commentField: UITextField!
    @IBOutlet weak var imageView: UIImageView!
    override func viewDidLoad() {
        super.viewDidLoad()

        // Do any additional setup after loading the view.
    }
    
    @IBAction func onCameraButton(_ sender: Any) {
        let picker = UIImagePickerController()
        // Easy way to get the camera
        picker.delegate = self //Once user takes myphoto  let me know what it is
        picker.allowsEditing = true // Second Screen
        
        // Is camera available.
        if UIImagePickerController.isSourceTypeAvailable(.camera){
            picker.sourceType = .camera
        }else{
            picker.sourceType = .photoLibrary
        }
        
        present(picker, animated: true, completion: nil)
        
    }
    
    func imagePickerController(_ picker: UIImagePickerController, didFinishPickingMediaWithInfo info: [UIImagePickerController.InfoKey : Any]) {
        let image = info[.editedImage] as! UIImage
        let size = CGSize(width: 300, height: 300)
        let scaledImage = image.af_imageScaled(to: size)
        
        imageView.image = scaledImage
        
        dismiss(animated: true, completion: nil)
    }
    @IBAction func onSubmitButton(_ sender: Any) {
        //creating tables
        let post = PFObject(className: "Posts")
        post["caption"] = commentField.text!
        post["author"] = PFUser.current()!
        
        //grabbing image data
        let imageData = imageView.image!.pngData()
        let file = PFFileObject(name:"image.png",data: imageData!)
        
        post["image"] = file
        
        post.saveInBackground{(success,error) in
            if success{
                self.dismiss(animated: true, completion: nil)
                print("Success")
            }else{
                print("Error")
            }
        
    }
    
    /*
    // MARK: - Navigation

    // In a storyboard-based application, you will often want to do a little preparation before navigation
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        // Get the new view controller using segue.destination.
        // Pass the selected object to the new view controller.
    }
    */

}
}
