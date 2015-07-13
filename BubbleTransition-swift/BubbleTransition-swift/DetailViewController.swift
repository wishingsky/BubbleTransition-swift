//
//  DetailViewController.swift
//  BubbleTransition-swift
//
//  Created by weixiaoyun on 15/7/13.
//  Copyright (c) 2015年 weixiaoyun. All rights reserved.
//

import UIKit

class DetailViewController: UIViewController {

    var detailDescriptionLabel: UILabel!

    var button: UIButton!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        self.button = UIButton(frame: CGRectMake(10, 10, 50, 50))
        self.button.layer.cornerRadius = self.button!.frame.size.width/2.0
        self.button.setTitle("+", forState: UIControlState.Normal)
        self.button.addTarget(self, action: "closeAction:", forControlEvents: UIControlEvents.TouchUpInside)
        self.view.addSubview(self.button!)
        
        self.button.transform = CGAffineTransformMakeRotation(CGFloat(M_PI_4))

        self.detailDescriptionLabel = UILabel(frame: CGRectMake(0, 50, self.view.frame.size.width, self.view.frame.size.height - 100))
        self.detailDescriptionLabel.text = "雷锋网消息，微软今天正式发布了Mac版Office 2016，Mac版Office 2016包含了如下组件：Word、Excel、PowerPoint、OneNote和Outlook，不过此次发布的只是基于云的Mac版Office 2016。独立版本的Office 2016则要等到9月份才会发布。微软为新版Word、Excel和PowerPoint重新设计了Ribbon界面，如今所有平台下的Office产品都将拥有一致的功能键分布——譬如“插入”标签下的某一个按键，在Mac版和Android版下的位置应该是一样的。Office 2016最明显的一项改进是增加了云端基集成，利用云端共享体验，将能有效提高与同事或友人间的协作办公效率。根据官方介绍显示，Office 2016 for Mac不仅继承了Office系列软件的办公便利性，而且还完美支持Mac产品特性，比如：全屏视图、多点触控手势以及Retina视网膜显示屏等等。截至目前，微软已经为iPhone、iPad、Android平板和Android智能手机分别发布了最新版本的Office应用。公司表示，针对Windows 10开发的“触屏友好版”通用Office应用将会在几周后发布"
        self.detailDescriptionLabel.numberOfLines = 0;
        self.view.addSubview(self.detailDescriptionLabel)
        // Do any additional setup after loading the view, typically from a nib.
    }

    override func viewWillAppear(animated: Bool) {
         super.viewWillAppear(animated)
//        UIView.animateWithDuration(0.5, animations: { () -> Void in
////            self.button!.layer.transform = CGAffineTransformMakeRotation(-M_PI_4*3.0)
//        })
    }
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }

    func closeAction(sender: AnyObject) {
        self.dismissViewControllerAnimated(true, completion: nil)
    }
}

