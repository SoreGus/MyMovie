//
//  MMSearchBar.swift
//  MyMovie
//
//  Created by Gustavo Luís Soré on 03/09/17.
//  Copyright © 2017 Gustavo Luís Soré. All rights reserved.
//

import UIKit

protocol MMSearchBarDelegate : class {
    func didRecognizeSearchText(searchText:String)
    func cancel()
}

class MMSearchBar: UISearchBar {
    
    private var hideYPosition:CGFloat!
    private var showYPosition:CGFloat!
    
    private var width:CGFloat!
    private var height:CGFloat!
    
    weak var movieSearchDelegate:MMSearchBarDelegate?

    init(screenFrame:CGRect,navigationBarHeight:CGFloat){
        
        height = 45
        width = screenFrame.width
        let yPosition:CGFloat = navigationBarHeight + 20
        
        showYPosition = yPosition
        hideYPosition = -height
        
        let frame = CGRect.init(x: 0, y: hideYPosition, width: width, height: height)
        
        super.init(frame: frame)
        
        self.backgroundColor = UIColor.lightGray
        
        self.placeholder = "Pesquisar Filme"
        
        self.delegate = self
    }
    
    func show(){
        
        UIView.animate(withDuration: 0.3,
                       delay: 0.0,
                       options: UIViewAnimationOptions.curveEaseIn,
                       animations: { () -> Void in
                        
                        self.frame = CGRect.init(x: 0, y: self.showYPosition, width: self.width, height: self.height)
                        
        }, completion: { (finished) -> Void in
            
        })
        
    }
    
    func hide(){
        
        UIView.animate(withDuration: 0.3,
                       delay: 0.0,
                       options: UIViewAnimationOptions.curveEaseIn,
                       animations: { () -> Void in
                        
                        self.frame = CGRect.init(x: 0, y: self.hideYPosition, width: self.width, height: self.height)
                        
        }, completion: { (finished) -> Void in
            
            
            // ....
        })
        
    }
    
    required init?(coder aDecoder: NSCoder) {
        super.init(coder: aDecoder)
    }

}

extension MMSearchBar : UISearchBarDelegate{
    
    func searchBarSearchButtonClicked(_ searchBar: UISearchBar) {
        
        self.movieSearchDelegate?.didRecognizeSearchText(searchText: searchBar.text!)
        
    }
    
    func searchBarCancelButtonClicked(_ searchBar: UISearchBar) {
        self.movieSearchDelegate?.cancel()
    }
    
}
