//
//  MMMovieManager.swift
//  MyMovie
//
//  Created by Gustavo Luís Soré on 02/09/17.
//  Copyright © 2017 Gustavo Luís Soré. All rights reserved.
//

import UIKit

class MMMovieManager: NSObject {

    let business = MMMovieBusiness()
    
    var arrayMovies:[MMMovieModel] = []
    
    static let shared = MMMovieManager()
    
    func getPopularMovies(completion:@escaping (_ success:Bool)->Void){
        
        business.getPopularMovies { (success, arrayMovies) in
            
            if success == true{
                
                MMMovieManager.shared.arrayMovies = arrayMovies!
                completion(true)
                
            } else{
                completion(false)
            }
            
        }
        
    }
    
    func searchMovies(seachString:String,completion:@escaping (_ success:Bool)->Void){
        
        business.searchMovies(seachString: seachString) { (success, arrayMovies) in
            
            if success == true{
                
                MMMovieManager.shared.arrayMovies = arrayMovies!
                completion(true)
                
            } else{
                completion(false)
            }
            
        }
        
    }
    
}
