//
//  MMMovieDetailViewController.swift
//  MyMovie
//
//  Created by Gustavo Luís Soré on 03/09/17.
//  Copyright © 2017 Gustavo Luís Soré. All rights reserved.
//

import UIKit

class MMMovieDetailViewController: MMBaseViewController {
    
    var movie:MMMovieModel! = nil

    @IBOutlet var tableView: UITableView!
    override func viewDidLoad() {
        super.viewDidLoad()
        
        movie = MMMovieManager.shared.selectedMovie

        self.title = movie.title
        
        self.tableView.delegate = self
        
        self.tableView.rowHeight = UITableViewAutomaticDimension
        self.tableView.estimatedRowHeight = 72.0
        
        self.tableView.delegate = self
        self.tableView.dataSource = self
        
        self.tableView.backgroundColor = UIColor.clear
        
        self.tableView.separatorStyle = .none
        
//        if movie.posterImagePath == nil{
//            self.posterImageView.image = #imageLiteral(resourceName: "placeholder")
//        } else{
//            self.posterImageView.sd_setImage(with: URL.init(string: movie.posterImagePath!), placeholderImage: UIImage.init(named: "placeholder"), options: .progressiveDownload, completed: nil)
//        }
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }

}

extension MMMovieDetailViewController : UITableViewDelegate, UITableViewDataSource{
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        
        if indexPath.row == 0{ // title
            
            let cell = tableView.dequeueReusableCell(withIdentifier: "simpleCell") as! MMSimpleTextCell
            
            cell.simpleTextLabel.text = movie.title
            
            cell.selectionStyle = .none
            
            return cell
            
        }
        
        if indexPath.row == 1{ // tagline
            
            let cell = tableView.dequeueReusableCell(withIdentifier: "simpleCell") as! MMSimpleTextCell
            
            cell.simpleTextLabel.text = movie.tagline
            cell.simpleTextLabel.font = UIFont.init(name: "System", size: 17)
            
            cell.selectionStyle = .none
            
            return cell
            
        }
        
        if indexPath.row == 2{ // poster
            
            let cell = tableView.dequeueReusableCell(withIdentifier: "posterCell") as! MMPosterCell
            
            if movie.posterImagePath == nil{
                cell.posterImageView.image = #imageLiteral(resourceName: "placeholder")
            } else{
                cell.posterImageView.sd_setImage(with: URL.init(string: movie.posterImagePath!), placeholderImage: UIImage.init(named: "placeholder"), options: .progressiveDownload, completed: nil)
            }
            
            cell.posterImageView.contentMode = .scaleAspectFit
            
            cell.selectionStyle = .none
            
            return cell
            
        }
        
        if indexPath.row == 3{ // overview
            
            let cell = tableView.dequeueReusableCell(withIdentifier: "overviewCell") as! MMOverviewCell
            
            cell.overviewLabel.text = movie.overview
            
            cell.selectionStyle = .none
            
            return cell
            
        }
        
        if indexPath.row == 4{ // release Date
            
            let cell = tableView.dequeueReusableCell(withIdentifier: "detailCell") as! MMDetailCell
            
            cell.titleLabel.text = "Release Date"
            cell.detailLabel.text = self.maskForDate(dateString: movie.releaseDate)
            
            cell.selectionStyle = .none
            
            return cell
            
        }
        
        if indexPath.row == 5{ // runtime
            
            let cell = tableView.dequeueReusableCell(withIdentifier: "detailCell") as! MMDetailCell
            
            cell.titleLabel.text = "Runtime"
            if movie.runtime != nil{
                cell.detailLabel.text = "\(movie.runtime!) minutes"
            } else{
                cell.detailLabel.text = "---"
            }
            
            cell.selectionStyle = .none
            
            return cell
            
        }
        
        if indexPath.row == 6{ // rating
            
            let cell = tableView.dequeueReusableCell(withIdentifier: "detailCell") as! MMDetailCell
            
            cell.titleLabel.text = "Rating"
            if movie.rating != nil{
                cell.detailLabel.text = String(format: "%.0f/10", movie.rating!)
            } else{
                cell.detailLabel.text = "---"
            }
            
            cell.selectionStyle = .none
            
            return cell
            
        }
        
        if indexPath.row == 7{ // genres
            
            let cell = tableView.dequeueReusableCell(withIdentifier: "overviewCell") as! MMOverviewCell
            
            cell.titleLabel.text = "Genres"
            cell.overviewLabel.text = arrayToString(array: movie.genres)
            
            cell.selectionStyle = .none
            
            return cell
            
        }
        
        if indexPath.row == 8{ // backdrop
            
            let cell = tableView.dequeueReusableCell(withIdentifier: "posterCell") as! MMPosterCell
            
            if movie.backdropImagePath == nil{
                cell.posterImageView.image = #imageLiteral(resourceName: "placeholder")
            } else{
                cell.posterImageView.sd_setImage(with: URL.init(string: movie.backdropImagePath!), placeholderImage: UIImage.init(named: "placeholder"), options: .progressiveDownload, completed: nil)
            }
            
            cell.posterImageView.contentMode = .scaleAspectFit
            
            cell.selectionStyle = .none
            
            return cell
            
        }
        
        return tableView.dequeueReusableCell(withIdentifier: "overviewCell")!
    }
    
    func arrayToString(array:[String]?) -> String{
        
        if array == nil || (array?.count)! < 1{
            return "---"
        }
        
        var result = ""
        
        for text in array!{
            
            result = "\(result) , \(text)"
            
        }
        
        let index = result.index(result.startIndex, offsetBy: 2)
        return result.substring(from: index)
        
    }
    
    func maskForDate(dateString:String?) -> String{
        
        if dateString == nil || (dateString?.characters.count)! < 10{
            return "---"
        }
        
        let formatter = DateFormatter.init()
        formatter.dateFormat = "yyyy-MM-dd"
        let date = formatter.date(from: dateString!)
        
        let newFormatter = DateFormatter.init()
        newFormatter.dateFormat = "dd/MM/yyyy"
        
        return newFormatter.string(from: date!)
        
    }
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        
        return 9
        
    }
    
}
