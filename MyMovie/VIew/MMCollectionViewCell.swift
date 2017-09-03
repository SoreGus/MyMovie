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
        
        posterImageView.sd_setImage(with: URL.init(string: movie.posterImagePath!))
        posterImageView.contentMode = .scaleAspectFit
        titleLabel.text = movie.title
        yearLabel.text = "\(movie.year!)"
        
    }
}
