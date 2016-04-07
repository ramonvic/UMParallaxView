//
//  ScrollViewController.swift
//  UMParallaxView Demo
//
//  Created by Ramon Vicente on 4/7/16.
//  Copyright © 2016 Umobi. All rights reserved.
//

import UIKit

class ScrollViewController: UIViewController, UIScrollViewDelegate {

    @IBOutlet var scrollView: UIScrollView!
    
    var headerView: UMParallaxView?
    
    var fixed: Bool = true
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        headerView = UMParallaxView(height: 200, fixed: fixed)
        headerView?.image = UIImage(named: "photo2")
        headerView?.attachTo(self.scrollView)
        
        headerView?.maxHeight = 999
        
        scrollView.contentSize = CGSize(width: self.view.frame.width, height: 1500)
    }
    
    func scrollViewDidScroll(scrollView: UIScrollView) {
        headerView?.scrollViewDidScroll(scrollView)
    }
}
