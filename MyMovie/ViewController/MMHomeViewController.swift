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
    
    var searchBar:MMSearchBar!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        collectionView.dataSource = self
        collectionView.delegate = self
        
        showLoading()
        
        if reachability.isReachable{
            self.loadPopularMovies()
        } else{
            showNotice(text: "Sem Conexão", time: nil)
        }
        
        let tap = UITapGestureRecognizer.init(target: self, action: #selector(hideKeyboard))
        self.view.addGestureRecognizer(tap)
        tap.delegate = self
        
        searchBar = MMSearchBar.init(screenFrame: self.view.frame, navigationBarHeight: (self.navigationController?.navigationBar.frame.height)!)
        searchBar.movieSearchDelegate = self
        self.view.addSubview(searchBar)
        
        reachability.whenReachable = { reachability in
            DispatchQueue.main.async {
                if MMMovieManager.shared.isSearch == false{
                    self.loadPopularMovies()
                } else{
                    self.loadSearchMovies(searchText: MMMovieManager.shared.searchText)
                }
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
    @IBAction func popularAction(_ sender: Any) {
        searchBar.resignFirstResponder()
        searchBar.hide()
        MMMovieManager.shared.isSearch = false
        if reachability.isReachable{
            self.loadPopularMovies()
        } else{
            showNotice(text: "Sem Conexão", time: nil)
        }
    }
    
    @IBAction func searchAction(_ sender: Any) {
        
        if MMMovieManager.shared.isSearch == false{
            
            searchBar.show()
            MMMovieManager.shared.isSearch = true
            
        } else{
            
            searchBar.hide()
            MMMovieManager.shared.isSearch = false
            
        }
        
    }
    
    func hideKeyboard(){
        
        searchBar.resignFirstResponder()
        
    }
    
    func loadPopularMovies(){
        
        MMMovieManager.shared.arrayMovies = []
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
    
    func loadSearchMovies(searchText:String){
        
        MMMovieManager.shared.arrayMovies = []
        
        showLoading()
        self.collectionView.reloadData()
        
        MMMovieManager.shared.searchMovies(seachString: searchText) { (success) in
            if success == true && MMMovieManager.shared.arrayMovies.count > 0{
                DispatchQueue.main.async {
                    self.hideLoading()
                    self.collectionView.reloadData()
                }
            } else if(success == true && MMMovieManager.shared.arrayMovies.count == 0){
                
                DispatchQueue.main.async {
                    self.hideLoading()
                    self.showNotice(text: "Pesquisa sem resultado.", time: nil)
                }
                
            }else{
                
                DispatchQueue.main.async {
                    self.hideLoading()
                    self.showNotice(text: "Ocorreu algum erro, tente novamente.", time: nil)
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

extension MMHomeViewController : MMSearchBarDelegate{
    
    func didRecognizeSearchText(searchText: String) {
        
        searchBar.resignFirstResponder()
        searchBar.hide()
        MMMovieManager.shared.isSearch = false
        
        if reachability.isReachable{
            MMMovieManager.shared.searchText = searchText
            loadSearchMovies(searchText: MMMovieManager.shared.searchText)
        } else{
            showNotice(text: "Sem Conexão", time: nil)
        }
        
    }
    
    func cancel() {
        
        searchBar.resignFirstResponder()
        searchBar.hide()
        
    }
    
}

extension MMHomeViewController : UIGestureRecognizerDelegate{
    
    func gestureRecognizer(_ gestureRecognizer: UIGestureRecognizer, shouldReceive touch: UITouch) -> Bool {
        
        if searchBar.isFirstResponder{
            searchBar.hide()
            searchBar.resignFirstResponder()
            return true
        }
        
        return false
        
    }
    
}
