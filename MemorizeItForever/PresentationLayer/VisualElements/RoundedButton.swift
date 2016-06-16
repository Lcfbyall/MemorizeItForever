//
//  RoundedButton.swift
//  MemorizeItForever
//
//  Created by Hadi Zamani on 5/11/16.
//  Copyright © 2016 SomeSimpleSolution. All rights reserved.
//

import UIKit

class RoundedButton: UIButton {
    
    // Only override drawRect: if you perform custom drawing.
    // An empty implementation adversely affects performance during animation.
    override func drawRect(rect: CGRect) {
        
        let width = bounds.width < bounds.height ? bounds.width : bounds.height
        
        let newRect = CGRectMake(bounds.midX - width / 2, bounds.midY - width / 2, width, width)
        
        let path = UIBezierPath(ovalInRect: newRect)
        let buttonColor  = UIColor(red: 10, green: 106, blue: 184)
        
        buttonColor.setFill()
        
        path.fill()
        
        self.contentMode = UIViewContentMode.Redraw
        
        self.setTitleColor(UIColor.whiteColor(), forState: UIControlState.Normal)
        
        self.titleLabel?.lineBreakMode = NSLineBreakMode.ByWordWrapping
        
        self.titleLabel?.textAlignment = NSTextAlignment.Center
        self.titleLabel?.backgroundColor = buttonColor
        
    }
    
    
}
