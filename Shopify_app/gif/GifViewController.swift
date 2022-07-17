//
//  GifViewController.swift
//  Shopify_app
//
//  Created by Mohamed Elkazzaz on 17/07/2022.
//

import UIKit

class GifViewController: UIViewController {
    @IBOutlet weak var gifImageView: UIImageView!
    
    override func viewDidLoad() {
        super.viewDidLoad()

        let jeremyGif = UIImage.gifImageWithName("funny")
            let imageView = UIImageView(image: jeremyGif)
            imageView.frame = CGRect(x: 20.0, y: 50.0, width: self.view.frame.size.width - 40, height: 150.0)
            view.addSubview(imageView)
        let imageData = try? Data(contentsOf: Bundle.main.url(forResource: "play", withExtension: "gif")!)
            let advTimeGif = UIImage.gifImageWithData(imageData!)
            let imageView2 = UIImageView(image: advTimeGif)
            imageView2.frame = CGRect(x: 20.0, y: 220.0, width:
            self.view.frame.size.width - 40, height: 150.0)
            view.addSubview(imageView2)
        let gifURL : String = "http://www.gifbin.com/bin/4802swswsw04.gif"
            let imageURL = UIImage.gifImageWithURL(gifURL)
            let imageView3 = UIImageView(image: imageURL)
            imageView3.frame = CGRect(x: 20.0, y: 390.0, width: self.view.frame.size.width - 40, height: 150.0)
            view.addSubview(imageView3)
    }
    

    
}
