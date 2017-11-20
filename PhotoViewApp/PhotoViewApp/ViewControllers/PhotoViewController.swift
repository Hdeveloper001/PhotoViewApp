//
//  PhotoViewController.swift
//  PhotoViewApp
//
//  Created by iOSpro on 15/11/17.
//  Copyright © 2017 iOSpro. All rights reserved.
//

import UIKit
import SVProgressHUD
import FirebaseDatabase

class PhotoViewController: UIViewController {

    @IBOutlet weak var img_photo: UIImageView!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        currentIndex = 0
        if (wakeupTime != ""){
            let timeFormatter = DateFormatter()
            timeFormatter.dateStyle = .none
            timeFormatter.dateFormat = "HH:mm a"
            timeFormatter.timeStyle = .short
            
            let currentTime = timeFormatter.string(from: Date())
            
            if isTimeValid(currentTime: currentTime){
                mFirebaseDB.child(albumID1).observe(.value, with: { (favourites) in
                    if let result = favourites.children.allObjects as? [DataSnapshot] {
                        PhotoUrlList = [String]()
                        for child in result {
                            let url = (child.value as? [String:AnyObject])?["url"] as! String
                            PhotoUrlList.append(url)
                        }
                        if (PhotoUrlList.count > 0){
                            self.img_photo.sd_setImage(with: URL(string: PhotoUrlList[0]))
                        }
                    } else {
                        print("no results")
                    }
                }) { (error) in
                    print(error.localizedDescription)
                }
            }
            
        }
        
        let swipeRight = UISwipeGestureRecognizer(target: self, action: #selector(responseToSwipeGesture))
        swipeRight.direction = UISwipeGestureRecognizerDirection.right
        self.img_photo.addGestureRecognizer(swipeRight)
        
        let swipeleft = UISwipeGestureRecognizer(target: self, action: #selector(responseToSwipeGesture))
        swipeleft.direction = UISwipeGestureRecognizerDirection.left
        self.img_photo.addGestureRecognizer(swipeleft)
        
        let tapGesture = UITapGestureRecognizer(target: self, action: #selector(responseToSwipeGesture))
        tapGesture.numberOfTapsRequired = 1
        self.img_photo.isUserInteractionEnabled = true
        self.img_photo.addGestureRecognizer(tapGesture)
        // Do any additional setup after loading the view.
    }
    
    func isTimeValid(currentTime : String) -> Bool{
        var time_temp = Int(wakeupTime.split(separator: " ")[0].split(separator: ":")[0])! + Int(wakeupTime.split(separator: " ")[0].split(separator: ":")[1])! / 100
        let wake_time = wakeupTime.split(separator: " ")[1] == "PM" ? time_temp + 12 : time_temp
        time_temp = Int(sleepTime.split(separator: " ")[0].split(separator: ":")[0])! + Int(sleepTime.split(separator: " ")[0].split(separator: ":")[1])! / 100
        let sleep_time = sleepTime.split(separator: " ")[1] == "PM" ? time_temp + 12 : time_temp
        
        time_temp = Int(currentTime.split(separator: " ")[0].split(separator: ":")[0])! + Int(currentTime.split(separator: " ")[0].split(separator: ":")[1])! / 100
        let current_time = currentTime.split(separator: " ")[1] == "PM" ? time_temp + 12 : time_temp
        
        if (current_time < wake_time || current_time > sleep_time){
            return false
        }
        return true
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    @objc func responseToSwipeGesture(gesture: UIGestureRecognizer){
        if let swipeGesture = gesture as? UISwipeGestureRecognizer {
            
            switch swipeGesture.direction {
                
            case UISwipeGestureRecognizerDirection.right:
                
                if (currentIndex > 0){
                    currentIndex -= 1
                    self.img_photo.sd_setImage(with: URL(string: PhotoUrlList[currentIndex]))
                }
                break
            case UISwipeGestureRecognizerDirection.left:
                if (currentIndex + 1 < PhotoUrlList.count){
                    currentIndex += 1
                    self.img_photo.sd_setImage(with: URL(string: PhotoUrlList[currentIndex]))
                }
                
                break
            default:
                break
            }
        }
        else{
            _ = self.navigationController?.popViewController(animated: true)

        }
    }
    
    @IBAction func btn_backClicked(_ sender: Any) {
        _ = self.navigationController?.popViewController(animated: true)
    }
    
    /*
    // MARK: - Navigation

    // In a storyboard-based application, you will often want to do a little preparation before navigation
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        // Get the new view controller using segue.destinationViewController.
        // Pass the selected object to the new view controller.
    }
    */

}
