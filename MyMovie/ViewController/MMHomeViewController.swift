//
//  MMHomeViewController.swift
//  MyMovie
//
//  Created by Gustavo Luís Soré on 02/09/17.
//  Copyright © 2017 Gustavo Luís Soré. All rights reserved.
//

import UIKit
import SDWebImage

class MMHomeViewController: UIViewController {

    @IBOutlet var collectionView: UICollectionView!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        collectionView.dataSource = self
        collectionView.delegate = self
        
        MMMovieManager.shared.getPopularMovies { (success) in
            if success{
                self.collectionView.reloadData()
            }
        }
        // Do any additional setup after loading the view.
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }

}

extension MMHomeViewController : UICollectionViewDelegate, UICollectionViewDataSource{
    
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        
        return MMMovieManager.shared.arrayMovies.count
        
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        
        //UICollectionViewCell *cell = [collectionView dequeueReusableCellWithReuseIdentifier:@"Cell" forIndexPath:indexPath];
        
        let cell = collectionView.dequeueReusableCell(withReuseIdentifier: "MovieCell", for: indexPath) as! MMCollectionViewCell
        
        let movie = MMMovieManager.shared.arrayMovies[indexPath.row]
        
        cell.posterImageView.sd_setImage(with: URL.init(string: movie.posterImagePath!))
        cell.posterImageView.contentMode = .scaleAspectFit
        cell.titleLabel.text = movie.title
        cell.yearLabel.text = "\(movie.year!)"
        
        return cell
    }
    
}
