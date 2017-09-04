//
//  MMMovieBusiness.swift
//  MyMovie
//
//  Created by Gustavo Luís Soré on 02/09/17.
//  Copyright © 2017 Gustavo Luís Soré. All rights reserved.
//

import UIKit

class MMMovieBusiness: NSObject {

    let movieProvider = MMMovieProvider()
    let movieImageProvider = MMMovieImageProvider()
    
    let kImageURLPrefix = "https://image.tmdb.org/t/p/w300"
    
    private let kMovie_KEY = "movie"
    
    func getPopularMovies(completion:@escaping (_ success:Bool,_ movies:[MMMovieModel]?)->Void){
        
        movieProvider.getPopularMovies { (success, data) in
            
            if success == false{
                completion(false,nil)
            } else{
                
                self.getMoviesWithImages(date: data!,completion: { (success, moviesArray) in
                    
                    completion(success,moviesArray)
                    
                })
                
            }
            
        }
        
    }
    
    func searchMovies(seachString:String,completion:@escaping (_ success:Bool,_ movies:[MMMovieModel]?)->Void){
        
        movieProvider.searchMovies(searchString: seachString) { (success, data) in
            
            if success == false{
                completion(false,nil)
            } else{
                
                self.getSearchMoviesWithImages(date: data!,completion: { (success, moviesArray) in
                    
                    completion(success,moviesArray)
                    
                })
                
            }
            
        }
        
    }
    
    func getMoviesWithImages(date:Data,completion:@escaping (_ success:Bool,_ movies:[MMMovieModel]?)->Void){
        
        self.parseMovies(data: date, completion: { (success, arrayMovies) in
            
            if success == false{
                completion(false,nil)
                return
            }
            
            var arrayMoviesWithImages:[MMMovieModel] = []
            
            for movie in arrayMovies!{
                
                self.getImagesFromTMDB(movie: movie, completion: { (success, movieWithImage) in
                    if success == false{
                        completion(false,nil)
                        return
                    }
                    
                    arrayMoviesWithImages.append(movieWithImage!)
                    
                    completion(true,arrayMoviesWithImages)
                })
                
            }
            
        })
        
    }
    
    func getSearchMoviesWithImages(date:Data,completion:@escaping (_ success:Bool,_ movies:[MMMovieModel]?)->Void){
        
        self.parseSearchMovies(data: date, completion: { (success, arrayMovies) in
            
            if success == false{
                completion(false,nil)
                return
            }
            
            var arrayMoviesWithImages:[MMMovieModel] = []
            
            if arrayMovies?.count == 0{
                completion(true,arrayMovies)
            }
            
            for movie in arrayMovies!{
                
                self.getImagesFromTMDB(movie: movie, completion: { (success, movieWithImage) in
                    if success == false{
                        completion(false,nil)
                        return
                    }
                    
                    arrayMoviesWithImages.append(movieWithImage!)
                    
                    completion(true,arrayMoviesWithImages)
                })
                
            }
            
        })
        
    }
    
    func getImagesFromTMDB(movie:MMMovieModel,completion:@escaping (_ success:Bool,_ movie:MMMovieModel?)->Void){
        
        movieImageProvider.getImagesFromTMDB(tmdbId: movie.tmdbId!) { (success, data) in
            
            if success == false{
                completion(false,nil)
            } else{
                
                self.parseImages(data: data!, movie: movie, completion: { (success, movie) in
                    
                    completion(success,movie)
                    
                })
                
            }
            
        }
        
    }
    
    func parseImages(data:Data,movie:MMMovieModel,completion:@escaping (_ success:Bool,_ movie:MMMovieModel?)->Void){
        
        do{
            
            guard let jsonDict = try JSONSerialization.jsonObject(with: data, options: JSONSerialization.ReadingOptions.allowFragments) as? [String:Any] else { completion(false,nil); return }
            
            let movieObject = movie
            
            if movieObject.mapImagePathsFromTMDBAPI(dict: jsonDict) == false{
                completion(false,nil)
                return
            }
            if movieObject.posterImagePath != nil{
                movieObject.posterImagePath = kImageURLPrefix + movieObject.posterImagePath!
            }
            if movieObject.backdropImagePath != nil{
                movieObject.backdropImagePath = kImageURLPrefix + movieObject.backdropImagePath!
            }
            
            completion(true,movieObject)
            
        } catch{
            completion(false,nil)
        }
        
    }
    
    func parseMovies(data:Data,completion:@escaping (_ success:Bool,_ movies:[MMMovieModel]?)->Void){
        
        do{
            
            guard let jsonArray = try JSONSerialization.jsonObject(with: data, options: JSONSerialization.ReadingOptions.allowFragments) as? [[String:Any]] else { completion(false,nil); return }
            
            var arrayMovies:[MMMovieModel] = []
            
            for object in jsonArray{
                
                let movie = MMMovieModel.init()
                if movie.mapFromAPI(dict: object) == false{
                    completion(false,nil)
                    return
                }
                arrayMovies.append(movie)
                
            }
            
            completion(true,arrayMovies)
            
        } catch{
            completion(false,nil)
        }
        
    }
    
    func parseSearchMovies(data:Data,completion:@escaping (_ success:Bool,_ movies:[MMMovieModel]?)->Void){
        
        do{
            
            guard let rootJsonArray = try JSONSerialization.jsonObject(with: data, options: JSONSerialization.ReadingOptions.allowFragments) as? [[String:Any]] else { completion(false,nil); return }
            
            
            var arrayMovies:[MMMovieModel] = []
            
            for rootObject in rootJsonArray{
                
                guard let object = rootObject[kMovie_KEY] as? [String:Any] else{
                    completion(false,nil)
                    return
                }
                
                let movie = MMMovieModel.init()
                if movie.mapFromAPI(dict: object) == false{
                    completion(false,nil)
                    return
                }
                arrayMovies.append(movie)
                
            }
            
            completion(true,arrayMovies)
            
        } catch{
            completion(false,nil)
        }
        
    }
    
}
