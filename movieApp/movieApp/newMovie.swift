//
//  newMovie.swift
//  movieApp
//
//  Created by Nishit Shah on 2024-03-24.
//

import UIKit

class newMovie: UIViewController {

    @IBOutlet var movieXName: UITextField!
    @IBOutlet var movieXYear: UITextField!
    @IBOutlet var movieXID: UITextField!
    @IBOutlet var movieXURl: UITextField!
    @IBOutlet var movieXPic: UITextField!
    @IBOutlet weak var imageView: UIImageView!
    override func viewDidLoad() {
        super.viewDidLoad()

    }
    
    @IBAction func addPhoto() {
        let vx = UIImagePickerController()
        vx.sourceType = .photoLibrary
        vx.delegate = self
        vx.allowsEditing = true
        present(vx, animated: true)
    }
    
    @IBAction func saveButton() {
        movieData.newMovie.movieName = movieXName.text ?? ""
        movieData.newMovie.movieYear = movieXYear.text ?? ""
        movieData.newMovie.movieImdbID = movieXID.text ?? ""
        movieData.newMovie.movieURL = movieXURl.text ?? ""
        movieData.newMovie.moviePhoto = movieXPic.text ?? ""
        
        let alert = UIAlertController(title: "Success", message: "New movie has been added", preferredStyle: .alert)
        alert.addAction(UIAlertAction(title: "OK", style: .default, handler: nil))
        self.present(alert, animated: true, completion: nil)
    }
}

extension newMovie: UIImagePickerControllerDelegate, UINavigationControllerDelegate
{

    func imagePickerController(_ picker: UIImagePickerController, didFinishPickingMediaWithInfo info: [UIImagePickerController.InfoKey : Any]) {
        
        if let image = info[UIImagePickerController.InfoKey(rawValue: "UIImagePickerControllerEditedImage")] as? UIImage{
            imageView.image = image
        }
        
        picker.dismiss(animated: true, completion: nil)
    }

    func imagePickerControllerDidCancel(_ picker: UIImagePickerController) {
        picker.dismiss(animated: true, completion: nil)
    }
}
