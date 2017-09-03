//
//  MMMovieProvider.swift
//  MyMovie
//
//  Created by Gustavo Luís Soré on 02/09/17.
//  Copyright © 2017 Gustavo Luís Soré. All rights reserved.
//

import UIKit

class MMMovieProvider: NSObject {

    private let baseURL = "https://api.trakt.tv/"
    private let popularURLComplement = "movies/popular?extended=full"
    private let searchMovieURLComplement = "search/movie?query=<search_name>&extended=full"
    
    private let kContentType_FIELD = "Content-Type"
    private let kApiVersion_FIELD = "trakt-api-version"
    private let kApiKey_FIELD = "trakt-api-key"
    
    private let kContentType_VALUE = "application/json"
    private let kApiVersion_VALUE = "2"
    private let kApiKey_VALUE = "77d47ae35f6f8570c81ffeba89f7e74bd29307f551d8d7ff3481ca46f22ae544"
    
    func getPopularMovies(completion:@escaping (_ success:Bool,_ data:Data?)->Void){
        
        let urlString = baseURL + popularURLComplement
        
        sendRequest(urlString:urlString) { (success, data) in
            completion(success,data)
        }
        
    }
    
    func searchMovies(searchString:String,completion:@escaping (_ success:Bool,_ data:Data?)->Void){
        
        var complement = searchMovieURLComplement
        complement = complement.replacingOccurrences(of: "<search_name>", with: searchString)
        
        let urlString = baseURL + complement
        
        sendRequest(urlString:urlString) { (success, data) in
            completion(success,data)
        }
        
    }
    
    private func sendRequest(urlString:String,completion:@escaping (_ success:Bool,_ data:Data?)->Void){
        
        let url = URL.init(string: urlString)
        
        let request = NSMutableURLRequest.init(url: url!)
        
        request.httpMethod = "GET"
        request.setValue(kContentType_VALUE, forHTTPHeaderField: kContentType_FIELD)
        request.setValue(kApiVersion_VALUE, forHTTPHeaderField: kApiVersion_FIELD)
        request.setValue(kApiKey_VALUE, forHTTPHeaderField: kApiKey_FIELD)
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
