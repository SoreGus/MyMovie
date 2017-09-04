//
//  MMCollectionViewCell.swift
//  MyMovie
//
//  Created by Gustavo Luís Soré on 02/09/17.
//  Copyright © 2017 Gustavo Luís Soré. All rights reserved.
//

import UIKit

class MMCollectionViewCell: UICollectionViewCell {
    
    @IBOutlet var posterImageView: UIImageView!
    @IBOutlet var titleLabel: UILabel!
    @IBOutlet var yearLabel: UILabel!
    
    func subscribe(movie:MMMovieModel){
        
        //posterImageView.sd_setImage(with: URL.init(string: movie.posterImagePath!))
        if movie.posterImagePath == nil{
            posterImageView.image = #imageLiteral(resourceName: "placeholder")
        } else{
            posterImageView.sd_setImage(with: URL.init(string: movie.posterImagePath!), placeholderImage: UIImage.init(named: "placeholder"), options: .progressiveDownload, completed: nil)
        }
        posterImageView.contentMode = .scaleAspectFit
        titleLabel.text = movie.title
        if movie.year != nil{
            yearLabel.text = "\(movie.year!)"
        } else{
            yearLabel.text = "---"
        }
        
    }
}
