//
//  tileImageViewController.swift
//  Feed
//
//  Created by Maryam Alimohammadi on 2/21/20.
//  Copyright © 2020 Maryam Alimohammadi. All rights reserved.
//

import UIKit

class TileImageViewController: UIViewController {

    @IBOutlet weak var imageView: UIImageView!
    var imageSource : String?
    public var titleName: String?
    
    override func viewDidLoad() {
        super.viewDidLoad()
        title = titleName
        loadImage()
       
    }
    

    func loadImage(){
        guard let imageSource = imageSource else{
            return
        }
        do {
            let url = URL(string: imageSource)!
            let data = try Data(contentsOf: url)
            self.imageView.image = UIImage(data: data)
        }
        catch{
            print(error)
        }
        
    }
  

}
