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
import ReachabilitySwift

class MMHomeViewController: MMBaseViewController {

    @IBOutlet var collectionView: UICollectionView!
    
    let reachability = Reachability()!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        collectionView.dataSource = self
        collectionView.delegate = self
        
        showLoading()
        
        if reachability.isReachable{
            loadMovies()
        } else{
            showNotice(text: "Sem Conexão", time: nil)
        }
        
        reachability.whenReachable = { reachability in
            DispatchQueue.main.async {
                self.loadMovies()
            }
        }
        
        reachability.whenUnreachable = { reachability in
            DispatchQueue.main.async {
                self.showNotice(text: "Sem Conexão", time: nil)
            }
        }
        
        do {
            try reachability.startNotifier()
        } catch {
            print("Unable to start notifier")
        }
        
    }
    
    func loadMovies(){
        
        MMMovieManager.shared.getPopularMovies { (success) in
            if success == true{
                DispatchQueue.main.async {
                    self.hideLoading()
                    self.collectionView.reloadData()
                }
            }
        }
        
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
        SDImageCache.shared().clearMemory()
        SDImageCache.shared().clearDisk { 
            
        }
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
