//
//  MMNoticeView.swift
//  MyMovie
//
//  Created by Gustavo Luís Soré on 03/09/17.
//  Copyright © 2017 Gustavo Luís Soré. All rights reserved.
//

import UIKit

class MMNoticeView: UILabel {
    
    private var hideYPosition:CGFloat!
    private var showYPosition:CGFloat!
    
    private var width:CGFloat!
    private var height:CGFloat!

    init(screenFrame:CGRect){
        
        height = 45
        width = screenFrame.width
        let yPosition = screenFrame.height - height
        
        showYPosition = yPosition
        hideYPosition = screenFrame.height
        
        let frame = CGRect.init(x: 0, y: hideYPosition, width: width, height: height)
        
        super.init(frame: frame)
        
        self.backgroundColor = UIColor.lightGray
        
        self.textColor = UIColor.white
        
        self.font = UIFont.init(name: "NewJuneMedium", size: 25)
        self.textAlignment = .center
        
    }
    
    func show(timeInterval:TimeInterval?){
        
        var time = timeInterval
        if time == nil{
            time = 4.0
        }
        
        UIView.animate(withDuration: 0.3,
                       delay: 0.0,
                       options: UIViewAnimationOptions.curveEaseIn,
                       animations: { () -> Void in
                        
                        self.frame = CGRect.init(x: 0, y: self.showYPosition, width: self.width, height: self.height)
                        
        }, completion: { (finished) -> Void in
            
            UIView.animate(withDuration: 0.3,
                           delay: time!,
                           options: UIViewAnimationOptions.curveEaseIn,
                           animations: { () -> Void in
                            
                            self.frame = CGRect.init(x: 0, y: self.hideYPosition, width: self.width, height: self.height)
                            
            }, completion: { (finished) -> Void in
                
                
                // ....
            })
            
        })
        
    }
    
    required init?(coder aDecoder: NSCoder) {
        super.init(coder: aDecoder)
    }

}
