//
//  TimePickerViewController.swift
//  PhotoViewApp
//
//  Created by iOSpro on 15/11/17.
//  Copyright © 2017 iOSpro. All rights reserved.
//

import UIKit

protocol TimePickerVCDelegate {
    func pick_time(code:String)
}

class TimePickerViewController: UIViewController {
    
    @IBOutlet weak var timePicker: UIDatePicker!
    
    var delegate: TimePickerVCDelegate?

    override func viewDidLoad() {
        super.viewDidLoad()

        // Do any additional setup after loading the view.
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    @IBAction func timePicker_ValueChanged(_ sender: Any) {
        let timeFormatter = DateFormatter()
        timeFormatter.dateStyle = .none
        timeFormatter.dateFormat = "HH:mm a"
        timeFormatter.timeStyle = .short
        
        let selectedTime : String = timeFormatter.string(from: timePicker.date)
        
        if (isWakeupSelecting){
            wakeupTime = selectedTime
            
            let dict = ["time" : selectedTime] as [String : Any]
            mFirebaseDB.child("usertimes").child("wakeuptime").setValue(dict)
        }
        else{
            sleepTime = selectedTime
            let dict = ["time" : selectedTime] as [String : Any]
            mFirebaseDB.child("usertimes").child("sleeptime").setValue(dict)
        }
        self.delegate?.pick_time(code: selectedTime)
    }
    
    @IBAction func btn_CloseClicked(_ sender: Any) {
        
        self.dismiss(animated: true, completion: nil)
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
