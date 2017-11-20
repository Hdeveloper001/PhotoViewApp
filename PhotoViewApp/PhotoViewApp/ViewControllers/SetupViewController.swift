//
//  SetupViewController.swift
//  PhotoViewApp
//
//  Created by iOSpro on 15/11/17.
//  Copyright © 2017 iOSpro. All rights reserved.
//

import UIKit
import FirebaseDatabase

class SetupViewController: UIViewController, TimePickerVCDelegate {

    @IBOutlet weak var txt_albumID: UITextField!
    
    @IBOutlet weak var txt_albumPIN: UITextField!
    
    @IBOutlet weak var btnSelectWakeUpTime: UIButton!
    
    @IBOutlet weak var btnSelectSleepTime: UIButton!
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    override func viewWillAppear(_ animated: Bool) {
        mFirebaseDB.child("usertimes").child("wakeuptime").observeSingleEvent(of:.value, with: { (favourites) in
            if let result = favourites.children.allObjects as? [DataSnapshot] {
                for child in result {
                    wakeupTime = (child.value as? String)!
                    self.btnSelectWakeUpTime.setTitle(wakeupTime, for: .normal)
                    break
                }
                
            } else {
                print("no results")
            }
        }) { (error) in
            print(error.localizedDescription)
        }
        mFirebaseDB.child("usertimes").child("sleeptime").observeSingleEvent(of:.value, with: { (favourites) in
            if let result = favourites.children.allObjects as? [DataSnapshot] {
                for child in result {
                    sleepTime = (child.value as? String)!
                    self.btnSelectSleepTime.setTitle(sleepTime, for: .normal)
                    break
                }
                
            } else {
                print("no results")
            }
        }) { (error) in
            print(error.localizedDescription)
        }
    }
    // MARK: - Button Event
    
    @IBAction func selectWakeupTime(_ sender: Any) {
        isWakeupSelecting = true
        
        let timePickerVC = self.storyboard?.instantiateViewController(withIdentifier: "TimePickerViewController") as! TimePickerViewController
        
        timePickerVC.delegate = self
        timePickerVC.modalPresentationStyle = .overCurrentContext
        self.present(timePickerVC, animated: true, completion: nil)
    }    
    
    @IBAction func selectSleepTime(_ sender: Any) {
        isWakeupSelecting = false
        
        let timePickerVC = self.storyboard?.instantiateViewController(withIdentifier: "TimePickerViewController") as! TimePickerViewController
        
        timePickerVC.delegate = self
        timePickerVC.modalPresentationStyle = .overCurrentContext
        self.present(timePickerVC, animated: true, completion: nil)
    }
    
    func pick_time(code: String) {
        if isWakeupSelecting{
            self.btnSelectWakeUpTime.setTitle(code, for: .normal)            
        }
        else{
            self.btnSelectSleepTime.setTitle(code, for: .normal)
        }
        
    }
    
    @IBAction func btn_goClicked(_ sender: Any) {
        
        if (txt_albumID.text == "ABC123" && txt_albumPIN.text == "1234"){
            let viewController = self.storyboard?.instantiateViewController(withIdentifier: "PhotoViewController") as! PhotoViewController
            self.navigationController?.pushViewController(viewController, animated: true)
        }
        else{
            let alert = UIAlertController(title: "Missing Field", message: "Please Album ID and PIN code.", preferredStyle: UIAlertControllerStyle.alert)
            alert.addAction(UIAlertAction(title: "OK", style: UIAlertActionStyle.default, handler: nil))
            self.present(alert, animated: true, completion: nil)
        }
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
