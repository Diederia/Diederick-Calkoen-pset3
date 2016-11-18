//
//  ViewController.swift
//  Diederick-Calkoen-pset3
//
//  Created by Diederick Calkoen on 12/11/16.
//  Copyright © 2016 Diederick Calkoen. All rights reserved.
//

import UIKit

class ViewController: UIViewController {
    
    @IBOutlet weak var searchData: UISearchBar!
    @IBOutlet weak var searchButton: UIButton!
    @IBOutlet weak var tableView: UITableView!
    
    var searchRequest: String?
    
    var titles: Array<String> = []
    var years:  Array<String> = []
    var genres: Array<String> = []
    var actors: Array<String> = []
    var banners: Array<String> = []
    var info: Array<String> = []
    
    var currentIndex: Int?
    
    let storage = UserDefaults.standard

    override func viewDidLoad() {
        super.viewDidLoad()
        
        // Check if there is something in the storage.
        if (self.storage.array(forKey: "Title") as? Array<String> != nil) {
            titles = (self.storage.array(forKey: "Title") as! Array<String>)
            years = (self.storage.array(forKey: "Year") as! Array<String>)
            genres = (self.storage.array(forKey: "Genre") as! Array<String>)
            actors = (self.storage.array(forKey: "Actors") as! Array<String>)
            banners = (self.storage.array(forKey: "Poster") as! Array<String>)
            info = (self.storage.array(forKey: "Plot") as! Array<String>)
        }
    }
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }

    @IBAction func searchForMovie(_ sender: Any) {
        
        if searchData.text == "" {
            let alertController = UIAlertController(title: "No input provided", message:
                "Enter a title of a movie", preferredStyle: UIAlertControllerStyle.alert)
            alertController.addAction(UIAlertAction(title: "Dismiss", style: UIAlertActionStyle.default,handler: nil))
            
            self.present(alertController, animated: true, completion: nil)
            return
        }
        
        // make url, also for titles of more than one string.
        searchRequest = searchData.text!.replacingOccurrences(of: " ", with: "+" )
        
        // Source: http://www.learnswiftonline.com/mini-tutorials/how-to-download-and-read-json/
        let requestURL: NSURL = NSURL(string: "https://www.omdbapi.com/?t=" + searchRequest! + "&y=&plot=full&r=json")!
        let urlRequest: NSMutableURLRequest = NSMutableURLRequest(url: requestURL as URL)
        let session = URLSession.shared
        let task = session.dataTask(with: urlRequest as URLRequest) {
            (data, response, error) -> Void in
            
            let httpResponse = response as! HTTPURLResponse
            let statusCode = httpResponse.statusCode
            
            if (statusCode == 200) {
                do{
                    let json = try JSONSerialization.jsonObject(with: data!, options: []) as! NSDictionary
                    
                    //
                    if (json["Response"] as? String == "False") {
                        return
                    } else if self.titles.contains((json["Title"] as? String)!) == true{
                        return
                    } else {
                        self.AddMovie(json: json)
                        self.updateStorage()
                        self.performSelector(onMainThread: #selector(ViewController.reloadTableView), with: nil, waitUntilDone: true)
                    }
                } catch {
                    print ("Error with JSON: \(error)")
                }
            } else if (statusCode == 400) {
                let alertController = UIAlertController(title: "Error 400", message:
                    "The server cannot or will not process the request due to an apparent client error", preferredStyle: UIAlertControllerStyle.alert)
                alertController.addAction(UIAlertAction(title: "Dismiss", style: UIAlertActionStyle.default,handler: nil))
                self.present(alertController, animated: true, completion: nil)
                return
                
            } else {
                let alertController = UIAlertController(title: "Error", message:
                    "Unknown error", preferredStyle: UIAlertControllerStyle.alert)
                alertController.addAction(UIAlertAction(title: "Dismiss", style: UIAlertActionStyle.default,handler: nil))
                self.present(alertController, animated: true, completion: nil)
                return
            }
            
        }
        task.resume()
        searchData.text = ""
    }
    
    func AddMovie(json: NSDictionary) {
        self.titles.append((json["Title"] as? String)!)
        self.years.append((json["Year"] as? String)!)
        self.genres.append((json["Genre"] as? String)!)
        self.actors.append((json["Actors"] as? String)!)
        self.banners.append((json["Poster"] as? String)!)
        self.info.append((json["Plot"] as? String)!)
    }
    
    func reloadTableView() {
        self.tableView.reloadData()
    }
    func updateStorage() {
        self.storage.set(self.titles, forKey: "Title")
        self.storage.set(self.years, forKey: "Year")
        self.storage.set(self.genres, forKey: "Genre")
        self.storage.set(self.actors, forKey: "Actors")
        self.storage.set(self.banners, forKey: "Poster")
        self.storage.set(self.info, forKey: "Plot")
    }
}

extension ViewController: UITableViewDataSource {
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return titles.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = self.tableView.dequeueReusableCell(withIdentifier: "cell") as! CustomCell
        
        cell.movieTitle.text = titles[indexPath.row]
        cell.movieGenre.text = genres[indexPath.row]
        
        if (banners[indexPath.row] != "N/A") {
            let banner = (banners[indexPath.row])
            let urlBanner = NSURL(string: banner)
            let dataBanner = NSData(contentsOf: urlBanner! as URL)
            if dataBanner != nil{
                cell.movieBanner.image = UIImage(data: dataBanner as! Data)
            } else {
                cell.movieBanner.image = UIImage(named: "no-image")
            }
        }
        else {
            cell.movieBanner.image = UIImage(named: "no-image")
            
        }
        currentIndex = indexPath.row
        return cell
    }
    
    // Deleting a row from the table is not working, Jullian and I doesn't understand why..
    func tableView(_ tableView: UITableView, canEditRowAt indexPath: IndexPath) -> Bool {
        return true
    }
    func tableView(_tableView: UITableView, commit editingStyle: UITableViewCellEditingStyle, forRowAt indexPath: IndexPath) {
        if editingStyle == UITableViewCellEditingStyle.delete {
            
            self.titles.remove(at: indexPath.row)
            self.years.remove(at: indexPath.row)
            self.genres.remove(at: indexPath.row)
            self.actors.remove(at: indexPath.row)
            self.banners.remove(at: indexPath.row)
            self.info.remove(at: indexPath.row)
            updateStorage()
            self.tableView.reloadData()
            
            tableView.deleteRows(at: [indexPath], with: .fade)
        }
    }
}

extension ViewController: UITableViewDelegate {
    func tableView(_ tableView: UITableView, didDeselectRowAt indexPath: IndexPath) {
        currentIndex = indexPath.row
    }
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        let singleCellVC = segue.destination as! CellViewController
        singleCellVC.movieTitle = self.titles[self.tableView.indexPathForSelectedRow!.row]
        singleCellVC.movieYear = self.years[self.tableView.indexPathForSelectedRow!.row]
        singleCellVC.movieGenre = self.genres[self.tableView.indexPathForSelectedRow!.row]
        singleCellVC.movieActors = self.actors[self.tableView.indexPathForSelectedRow!.row]
        singleCellVC.movieBanner = self.banners[self.tableView.indexPathForSelectedRow!.row]
        singleCellVC.movieInfo = self.info[self.tableView.indexPathForSelectedRow!.row]
        
    }
}
    
