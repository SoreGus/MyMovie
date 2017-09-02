//
//  MMMovieModel.swift
//  MyMovie
//
//  Created by Gustavo Luís Soré on 02/09/17.
//  Copyright © 2017 Gustavo Luís Soré. All rights reserved.
//

import UIKit

class MMMovieModel: NSObject {
    
    private let kTitle_KEY = "title"
    private let kYear_KEY = "year"
    private let kIDs_KEY = "ids"
    private let kTMdbId_KEY = "tmdb"
    private let kReleaseDate_KEY = "released"
    private let kRunTime_KEY = "runtime"
    private let kTagline_KEY = "tagline"
    private let kOverview_KEY = "overview"
    private let kRating_KEY = "rating"
    
    var title:String!
    var year:Int!
    var tmdbId:Int!
    var releaseDate:String!
    var runtime:Int!
    var tagline:String!
    var overview:String!
    var rating:Double!
    
    override init(){
        
    }
    
    func mapFromAPI(dict:[String:Any]) -> Bool{
        
        guard let title = dict[kTitle_KEY] as? String else { return false }
        guard let year = dict[kYear_KEY] as? Int else { return false }
        guard let idsDict = dict[kIDs_KEY] as? [String:Any] else { return false }
        guard let tmdbId = idsDict[kTMdbId_KEY] as? Int else { return false }
        guard let releaseDate = dict[kReleaseDate_KEY] as? String else { return false }
        guard let runtime = dict[kRunTime_KEY] as? Int else { return false }
        guard let tagline = dict[kTagline_KEY] as? String else { return false }
        guard let overview = dict[kOverview_KEY] as? String else { return false }
        guard let rating = dict[kRating_KEY] as? Double else { return false }
        
        self.title = title
        self.year = year
        self.tmdbId = tmdbId
        self.releaseDate = releaseDate
        self.runtime = runtime
        self.tagline = tagline
        self.overview = overview
        self.rating = rating
        
        return true
        
    }
    
    func toDict() -> [String:Any]{
        
        var dict:[String:Any] = [:]
        
        dict[kTitle_KEY] = self.title
        dict[kYear_KEY] = self.year
        dict[kTMdbId_KEY] = self.tmdbId
        dict[kReleaseDate_KEY] = self.releaseDate
        dict[kRunTime_KEY] = self.runtime
        dict[kTagline_KEY] = self.tagline
        dict[kOverview_KEY] = self.overview
        dict[kRating_KEY] = self.rating
        
        return dict
        
    }

}
