//
//  MMBaseViewController.swift
//  MyMovie
//
//  Created by Gustavo Luís Soré on 03/09/17.
//  Copyright © 2017 Gustavo Luís Soré. All rights reserved.
//

import UIKit
import AASquaresLoading

class MMBaseViewController: UIViewController {
    
    var loadingSquare:AASquaresLoading?
    var noticeView:MMNoticeView! = nil

    override func viewDidLoad() {
        super.viewDidLoad()
        
    }
    
    func showNotice(text:String,time:TimeInterval?){
        
        if noticeView == nil{
            noticeView = MMNoticeView.init(screenFrame: self.view.frame)
            self.view.addSubview(noticeView)
        }
        
        noticeView.text = text
        
        noticeView.show(timeInterval: time)
        
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
