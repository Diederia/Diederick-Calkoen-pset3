//
//  CellViewController.swift
//  Diederick-Calkoen-pset3
//
//  Created by Diederick Calkoen on 16/11/16.
//  Copyright © 2016 Diederick Calkoen. All rights reserved.
//

import UIKit

class CellViewController: UIViewController {
    
    @IBOutlet weak var titleLabel: UILabel!
    @IBOutlet weak var yearLabel: UILabel!
    @IBOutlet weak var genreLabel: UILabel!
    @IBOutlet weak var actorsLabel: UILabel!
    @IBOutlet weak var bannerImage: UIImageView!
    @IBOutlet weak var infoText: UITextView!
        
    var movieTitle: String?
    var movieYear: String?
    var movieGenre: String?
    var movieActors: String?
    var movieBanner: String?
    var movieInfo: String?
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        titleLabel.text = movieTitle
        yearLabel.text = movieYear
        genreLabel.text = movieGenre
        actorsLabel.text = movieActors
        infoText.text = movieInfo
        
    
        if (movieBanner != "N/A") {
            let banner = movieBanner!
            let urlBanner = NSURL(string: banner)
            let dataBanner = NSData(contentsOf: urlBanner! as URL)
            if (dataBanner != nil) {
                bannerImage.image = UIImage(data: dataBanner as! Data)
            } else {
                bannerImage.image = UIImage(named: "no-image")
            }
        }else {
            bannerImage.image = UIImage(named: "no-image")
        }
    }
    
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
}
