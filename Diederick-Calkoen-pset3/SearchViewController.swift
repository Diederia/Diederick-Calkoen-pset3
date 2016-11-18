//
//  SearchViewController.swift
//  Diederick-Calkoen-pset3
//
//  Created by Diederick Calkoen on 16/11/16.
//  Copyright © 2016 Diederick Calkoen. All rights reserved.
//
import UIKit

class SingleViewController: UIViewController {
    
    @IBOutlet weak var titleLabel: UILabel!
    @IBOutlet weak var yearLabel: UILabel!
    @IBOutlet weak var genreLabel: UILabel!
    @IBOutlet weak var actorsLabel: UILabel!
    @IBOutlet weak var bannerImage: UIImageView!
    @IBOutlet weak var infoText: UITextView!
    @IBOutlet weak var saveButton: UIButton!
    
    var movieTitle: String?
    var movieYear: String?
    var movieGenre: String?
    var movieActors: String?
    var movieBanner: String?
    var movieInfo: String?
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        // Do any additional setup after loading the view.
        titleLabel.text = movieTitle
        yearLabel.text = movieYear
        genreLabel.text = movieGenre
        actorsLabel.text = movieActors
        infoText.text = movieInfo
        
    }
    
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    
    /*
     // MARK: - Navigation
     
     // In a storyboard-based application, you will often want to do a little preparation before navigation
     override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
     // Get the new view controller using segue.destinationViewController.
     // Pass the selected object to the new view controller.
     }
     */
    
}

