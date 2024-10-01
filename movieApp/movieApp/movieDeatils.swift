//
//  movieDeatils.swift
//  movieApp
//
//  Created by Nishit Shah on 2024-03-24.
//

import UIKit

class movieDeatils: UIViewController {

    @IBOutlet var movieImage2: UIImageView!
    @IBOutlet var movieLabel2: UILabel!
    @IBOutlet var movieYear2: UILabel!
    @IBOutlet var movieIMDBid1: UILabel!
    @IBOutlet weak var linkToMovie: UILabel!
    
    var img = ""
    var name = ""
    var year = ""
    var id = ""
    var link = ""
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        movieImage2.image = UIImage(named: img)
        movieLabel2.text = name
        movieYear2.text = year
        movieIMDBid1.text = id
        
        // Add logic to hyperlink the UILabel "linkToMovie" to var link.
        // Note : var link will be populated from another screen.
        let tapGesture = UITapGestureRecognizer(target: self, action: #selector(openLink(_:)))
        linkToMovie.isUserInteractionEnabled = true
        linkToMovie.addGestureRecognizer(tapGesture)
    }
    
    @objc func openLink(_ sender: UITapGestureRecognizer) {
        if let url = URL(string: link) {
            UIApplication.shared.open(url)
        }
    }
}
