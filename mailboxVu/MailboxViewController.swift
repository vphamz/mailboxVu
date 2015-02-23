//
//  MailboxViewController.swift
//  mailboxVu
//
//  Created by Vuhuan Pham on 2/22/15.
//  Copyright (c) 2015 Vuhuan Pham. All rights reserved.
//

import UIKit

class MailboxViewController: UIViewController {

    @IBOutlet weak var entireView: UIView!
    @IBOutlet weak var scrollView: UIScrollView!
    @IBOutlet weak var feedImage: UIImageView!
    @IBOutlet weak var messageImage: UIImageView!
    @IBOutlet weak var messageView: UIView!
    @IBOutlet weak var laterImage: UIImageView!
    @IBOutlet weak var rescheduleView: UIView!
    @IBOutlet weak var archiveImage: UIImageView!
    @IBOutlet weak var deleteImage: UIImageView!
    @IBOutlet weak var listImage: UIImageView!
    
    var startingMessageCenter: CGPoint!
    var startingViewCenter: CGPoint!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        scrollView.contentSize = feedImage.frame.size
        listImage.hidden = true
        deleteImage.hidden = true

        // Do any additional setup after loading the view.
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    

    /*
    // MARK: - Navigation

    // In a storyboard-based application, you will often want to do a little preparation before navigation
    override func prepareForSegue(segue: UIStoryboardSegue, sender: AnyObject?) {
        // Get the new view controller using segue.destinationViewController.
        // Pass the selected object to the new view controller.
    }
    */

    @IBAction func didPanMessage(sender: UIPanGestureRecognizer) {
        
        var translation = sender.translationInView(view)
        
        if (sender.state == UIGestureRecognizerState.Began) {
            startingMessageCenter = messageImage.center
        } else if (sender.state == UIGestureRecognizerState.Changed) {
            messageImage.center = CGPoint(x: startingMessageCenter.x + translation.x, y: messageImage.center.y)
            
            if (messageImage.center.x < -40) {
                messageView.backgroundColor = UIColor.orangeColor()
            } else if (messageImage.center.x < 110) {
                messageView.backgroundColor = UIColor.yellowColor()
            } else if (messageImage.center.x >= 360) {
                messageView.backgroundColor = UIColor.redColor()
            } else if (messageImage.center.x >= 210) {
                messageView.backgroundColor = UIColor.greenColor()
            } else {
                messageView.backgroundColor = UIColor.lightGrayColor()
            }
            
            
            
        } else if (sender.state == UIGestureRecognizerState.Ended) {
            
            if (messageImage.center.x < 0) {
                
                messageImage.center.x = -200
                
                rescheduleView.hidden = false
                
            } else {
                UIView.animateWithDuration(0.15, animations: { () -> Void in
           
                    self.messageImage.center = self.startingMessageCenter
            })
            }
            
            
        }
        
        // LATER AND LIST ICONS
        if (messageImage.center.x < -40) {
            laterImage.hidden = true
            listImage.hidden = false
            listImage.center.x = messageImage.center.x + 190
        }
        else if (messageImage.center.x < 110) {
            laterImage.hidden = false
            listImage.hidden = true
            laterImage.center.x = messageImage.center.x + 190
        } else {
            laterImage.hidden = false
            listImage.hidden = true
            laterImage.center.x = 300
        }
        
        
        // ARCHIVE AND DELETE ICONS
        if (messageImage.center.x > 360) {
            archiveImage.hidden = true
            deleteImage.hidden = false
            deleteImage.center.x = messageImage.center.x - 190
        }
        else if (messageImage.center.x > 210) {
            archiveImage.hidden = false
            deleteImage.hidden = true
            archiveImage.center.x = messageImage.center.x - 190
        } else {
            archiveImage.hidden = false
            deleteImage.hidden = true
            archiveImage.center.x = 20
        }
        
        
    }
    
    
    @IBAction func didTapReschedule(sender: AnyObject) {
        
        rescheduleView.hidden = true
        
        UIView.animateWithDuration(0.15, animations: { () -> Void in
            
            self.messageImage.center = self.startingMessageCenter
        })

        
        
    }
    

    @IBAction func didPanMenu(sender: UIPanGestureRecognizer) {
        
        var translation = sender.translationInView(view)
        
        if (sender.state == UIGestureRecognizerState.Began) {
            startingViewCenter = entireView.center
        } else if (sender.state == UIGestureRecognizerState.Changed) {
            entireView.center = CGPoint(x: startingViewCenter.x + translation.x, y: entireView.center.y)
        } else if (sender.state == UIGestureRecognizerState.Ended) {
            
            if (entireView.center.x > 320) {
                
                entireView.center.x = 400
                
            } else {
                UIView.animateWithDuration(0.15, animations: { () -> Void in
                    
                    self.entireView.center = CGPointMake(160, 568/2)
                })
            }
            
            
        }
        
    }
    
    
    
}
