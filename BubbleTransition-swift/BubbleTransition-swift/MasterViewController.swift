//
//  MasterViewController.swift
//  BubbleTransition-swift
//
//  Created by weixiaoyun on 15/7/13.
//  Copyright (c) 2015年 weixiaoyun. All rights reserved.
//

import UIKit

class MasterViewController: UIViewController, UITableViewDelegate, UITableViewDataSource, UIViewControllerTransitioningDelegate {

    var objects = ["武汉","上海","北京","深圳","广州","重庆","香港","台海","天津"]

    var tableView: UITableView?
    
    var transitionButton: UIButton!
    let transition = BubbleTransition()

    override func awakeFromNib() {
        super.awakeFromNib()
    }

    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view, typically from a nib.
        
        self.tableView = UITableView(frame: CGRectMake(0, 20, self.view.frame.size.width, self.view.frame.size.height - 44), style: .Plain)
        self.tableView!.delegate = self
        self.tableView!.dataSource = self;
        self.tableView!.registerClass(UITableViewCell.self, forCellReuseIdentifier: "cell")
        self.view.addSubview(self.tableView!)
        
        transitionButton = UIButton(frame: CGRectMake(self.view.frame.size.width - 70, self.view.frame.size.height-60, 50, 50))
        transitionButton.backgroundColor = UIColor.darkGrayColor()
        transitionButton.layer.cornerRadius = transitionButton.frame.size.width/2
        transitionButton.setTitle("+", forState: .Normal)
        transitionButton.addTarget(self, action: "animationPresentedViewController:", forControlEvents:.TouchUpInside)
        self.view.addSubview(transitionButton)
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }

    // MARK: - Table View

    func numberOfSectionsInTableView(tableView: UITableView) -> Int {
        return 1
    }

    func tableView(tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return objects.count
    }

    func tableView(tableView: UITableView, cellForRowAtIndexPath indexPath: NSIndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCellWithIdentifier("cell", forIndexPath: indexPath) 
        let row=indexPath.row as Int
        cell.textLabel!.text=self.objects[row]
        return cell;
    }

    func tableView(tableView: UITableView, canEditRowAtIndexPath indexPath: NSIndexPath) -> Bool {
        // Return false if you do not want the specified item to be editable.
        return true
    }

    func tableView(tableView: UITableView, didSelectRowAtIndexPath indexPath: NSIndexPath) {
        tableView.deselectRowAtIndexPath(indexPath, animated: true)
        let viewController: DetailViewController = DetailViewController()
        self.navigationController?.pushViewController(viewController, animated: true)
    }
    
    func tableView(tableView: UITableView, commitEditingStyle editingStyle: UITableViewCellEditingStyle, forRowAtIndexPath indexPath: NSIndexPath) {
        if editingStyle == .Delete {
            objects.removeAtIndex(indexPath.row)
            tableView.deleteRowsAtIndexPaths([indexPath], withRowAnimation: .Fade)
        } else if editingStyle == .Insert {
            // Create a new instance of the appropriate class, insert it into the array, and add a new row to the table view.
        }
    }

    func animationControllerForPresentedController(presented: UIViewController, presentingController presenting: UIViewController, sourceController source: UIViewController) -> UIViewControllerAnimatedTransitioning? {
        transition.transitionMode = .Present
        transition.startRect = transitionButton.frame
        transition.bubbleColor = transitionButton.backgroundColor!
        return transition
    }
    
    func animationControllerForDismissedController(dismissed: UIViewController) -> UIViewControllerAnimatedTransitioning? {
        transition.transitionMode = .Dismiss
        transition.startRect = transitionButton.frame
        transition.bubbleColor = transitionButton.backgroundColor!
        return transition
    }
    
    func animationPresentedViewController(sender: AnyObject) {
        let viewController: DetailViewController = DetailViewController()
        viewController.transitioningDelegate = self;
        viewController.modalPresentationStyle = UIModalPresentationStyle.Custom;
        self.presentViewController(viewController, animated: true, completion: nil)
    }
}

