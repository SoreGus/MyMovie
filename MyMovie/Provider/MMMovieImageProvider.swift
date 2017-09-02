//
//  MMMovieImageProvider.swift
//  MyMovie
//
//  Created by Gustavo Luís Soré on 02/09/17.
//  Copyright © 2017 Gustavo Luís Soré. All rights reserved.
//

import UIKit

class MMMovieImageProvider: NSObject {
    
    private let baseURL = "https://api.themoviedb.org/3/movie/"
    
    private let kApiKey_FIELD = "api_key"
    private let kApiKey_VALUE = "de34a13151f61aaa51085fbf164f3918"
    
    func getImagesFromTMDB(tmdbId:Int,completion:@escaping (_ success:Bool,_ data:Data?)->Void){
        
        let urlString = baseURL + "\(tmdbId)" + "?" + kApiKey_FIELD + "=" + kApiKey_VALUE
        
        sendRequest(urlString:urlString) { (success, data) in
            completion(success,data)
        }
        
    }
    
    private func sendRequest(urlString:String,completion:@escaping (_ success:Bool,_ data:Data?)->Void){
        
        let url = URL.init(string: urlString)
        
        let request = NSMutableURLRequest.init(url: url!)
        
        request.httpMethod = "GET"
        request.timeoutInterval = 30.0
        
        let task = URLSession.shared.dataTask(with: request as URLRequest) { (data, response, error) in
            
            if error == nil{
                completion(true,data!)
            } else{
                completion(false,nil)
            }
            
        }
        
        task.resume()
        
    }

}
