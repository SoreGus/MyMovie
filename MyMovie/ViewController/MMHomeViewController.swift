//
//  MMHomeViewController.swift
//  MyMovie
//
//  Created by Gustavo Luís Soré on 02/09/17.
//  Copyright © 2017 Gustavo Luís Soré. All rights reserved.
//

import UIKit
import SDWebImage
import AASquaresLoading

class MMHomeViewController: UIViewController {

    @IBOutlet var collectionView: UICollectionView!
    
    var loadingSquare:AASquaresLoading?
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        collectionView.dataSource = self
        collectionView.delegate = self
        
        showLoading()
        
        MMMovieManager.shared.getPopularMovies { (success) in
            if success == true{
                DispatchQueue.main.async {
                    self.hideLoading()
                    self.collectionView.reloadData()
                }
            }
        }
        
    }
    
    func showLoading(){
        
        if loadingSquare == nil{
            loadingSquare = AASquaresLoading(target: self.view, size: 100)
            loadingSquare?.backgroundColor = UIColor.clear
            loadingSquare?.color = UIColor.blue
        }
        loadingSquare?.start()
        
    }
    
    func hideLoading(){
        
        if loadingSquare != nil{
            loadingSquare?.stop()
        }
        
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
        
        let cell = collectionView.dequeueReusableCell(withReuseIdentifier: "MovieCell", for: indexPath) as! MMCollectionViewCell
        
        let movie = MMMovieManager.shared.arrayMovies[indexPath.row]
        cell.subscribe(movie: movie)
        
        //print(SDImageCache.shared().getSize())
        
        return cell
    }
    
}
