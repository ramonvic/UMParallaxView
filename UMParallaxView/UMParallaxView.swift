//
//  UMParallaxView.swift
//
//  Created by Ramon Vicente on 4/7/16.
//  Copyright © 2016 Umobi. All rights reserved.
//

import UIKit

class UMParallaxView: UIView {
    
    private var heightLayoutConstraint: NSLayoutConstraint?
    private var bottomLayoutConstraint: NSLayoutConstraint?
    private var containerLayoutConstraint: NSLayoutConstraint?
    
    private var containerView = UIView()
    
    private var imageView = UIImageView()
    
    private var scrollView: UIScrollView? = nil {
        didSet {
            reloadPosition()
        }
    }
    
    var height: CGFloat = 0 {
        didSet {
            self.frame.size.height = height
            if scrollView != nil {
                scrollView!.contentInset = UIEdgeInsetsMake(height, 0, 0, 0);
            }
            reloadPosition()
        }
    }
    
    var minHeight: CGFloat = 64 {
        didSet {
            reloadPosition()
        }
    }
    
    private var _maxHeight: CGFloat = 0
    
    var maxHeight: CGFloat {
        get {
            return _maxHeight <= height ? height*1.5 : _maxHeight
        }
        set {
            _maxHeight = newValue
        }
    }
    
    var fixed: Bool = true {
        didSet {
            reloadPosition()
        }
    }
    
    var zoomFactor: CGFloat = 2 {
        didSet {
            reloadPosition()
        }
    }
    
    var image:UIImage? {
        didSet{
            imageView.image = image
        }
    }
    
    convenience init?(height: CGFloat, fixed: Bool = true) {
        self.init(frame: CGRectZero)
        self.height = height
        self.fixed = fixed
    }
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        prepareView()
    }
    
    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    func attachTo(scrollView: UIScrollView!) {
        scrollView.addSubview(self)
        self.scrollView = scrollView
        
        self.frame = CGRect(x: 0, y: 0, width: scrollView.bounds.width, height: self.height)
        scrollView!.contentInset = UIEdgeInsetsMake(height, 0, 0, 0);
        
        reloadPosition()
    }
    
    private func prepareView() {
        
        self.backgroundColor = UIColor.whiteColor()
        containerView.translatesAutoresizingMaskIntoConstraints = false
        containerView.backgroundColor = UIColor.clearColor()
        containerView.clipsToBounds = true
        
        imageView.translatesAutoresizingMaskIntoConstraints = false
        imageView.backgroundColor = UIColor.clearColor()
        imageView.clipsToBounds = true
        imageView.contentMode = .ScaleAspectFill
        
        containerView.addSubview(imageView)
        self.addSubview(containerView)
        
        let containerHorizontalLayoutConstraint = NSLayoutConstraint.constraintsWithVisualFormat("H:|[containerView]|", options: NSLayoutFormatOptions(rawValue: 0), metrics: nil, views: ["containerView" : containerView])
        let containerVerticalLayoutConstraint = NSLayoutConstraint.constraintsWithVisualFormat("V:[containerView]|", options: NSLayoutFormatOptions(rawValue: 0), metrics: nil, views: ["containerView" : containerView])
        containerLayoutConstraint = NSLayoutConstraint(item: containerView, attribute: .Height, relatedBy: .Equal, toItem: self, attribute: .Height, multiplier: 1.0, constant: 0.0)
        
        let imageViewHorizontalLayoutConstraint = NSLayoutConstraint.constraintsWithVisualFormat("H:|[imageView]|", options: NSLayoutFormatOptions(rawValue: 0), metrics: nil, views: ["imageView" : imageView])
        bottomLayoutConstraint = NSLayoutConstraint(item: imageView, attribute: .Bottom, relatedBy: .Equal, toItem: containerView, attribute: .Bottom, multiplier: 1.0, constant: 0.0)
        heightLayoutConstraint = NSLayoutConstraint(item: imageView, attribute: .Height, relatedBy: .Equal, toItem: containerView, attribute: .Height, multiplier: 1.0, constant: 0.0)
        
        
        containerView.addConstraints(imageViewHorizontalLayoutConstraint)
        containerView.addConstraint(bottomLayoutConstraint!)
        containerView.addConstraint(heightLayoutConstraint!)
        
        addConstraints(containerHorizontalLayoutConstraint)
        addConstraints(containerVerticalLayoutConstraint)
        addConstraint(containerLayoutConstraint!)
    }
    
    private func reloadPosition() {
        
        if scrollView != nil {
            let offsetY: CGFloat = (scrollView!.contentOffset.y + height);
            let offsetYInverse = -offsetY;
            
            var newheight = height - offsetY
            newheight = newheight > minHeight ? newheight : minHeight;
            if fixed {
                newheight = newheight < maxHeight ? newheight : maxHeight;
            }
            
            var bottonConstant = offsetY >= 0 ? 0 : offsetYInverse
            if fixed {
                bottonConstant = bottonConstant > (maxHeight-height) ? (maxHeight-height) : bottonConstant
            }
            
            var heightConstant = newheight - (newheight * (zoomFactor > 3 ? 3 : zoomFactor) / 3)
            if !fixed {
                heightConstant = heightConstant > offsetYInverse ? heightConstant : offsetYInverse
            }
            
            
            containerLayoutConstraint!.constant = heightConstant
            heightLayoutConstraint!.constant = heightConstant
            bottomLayoutConstraint!.constant = bottonConstant/3
            
            if fixed {
                self.frame.size.height = newheight;
                self.frame.origin.y = offsetY - height
            } else {
                containerView.clipsToBounds = offsetY <= 0
                self.frame.origin.y = -height
            }
        }
    }
    
    func scrollViewDidScroll(scrollView: UIScrollView) {
        self.scrollView = scrollView
        reloadPosition()
    }
}
