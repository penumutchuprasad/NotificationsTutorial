//ViewController.swift
/*
 * LKNotificationTutorial
 * Created by penumutchu.prasad@gmail.com on 09/08/18
 * Is a product created by abnboys
 * For the  in the LKNotificationTutorial
 
 * Here the permission is granted to this file with free of use anywhere in the IOS Projects.
 * Copyright © 2018 ABNBoys.com All rights reserved.
*/

import UIKit
import CoreLocation

class ViewController: UIViewController {
    
    
    var datePicker: UIDatePicker!
    @IBOutlet var stackViewTopConstraint: NSLayoutConstraint!
    @IBOutlet weak var timerTF: UITextField!
    @IBOutlet weak var calenderTF: UITextField!
    @IBOutlet weak var locationTF: UITextField!

    override func viewDidLoad() {
        super.viewDidLoad()
        
        timerTF.delegate = self
        calenderTF.delegate = self
//        locationTF.delegate = self
        locationTF.inputView = UIView()

    }
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        
        self.view.addTap()
        
    }
    
    override func viewWillDisappear(_ animated: Bool) {
        super.viewWillDisappear(animated)
        
        self.view.removeTap()
        
    }
    
    func showPicker(_ shouldShow: Bool) {
        // DatePicker
        if shouldShow {
            self.datePicker = UIDatePicker(frame:CGRect(x: 0, y: 0, width: self.view.frame.size.width, height: 220))
            self.datePicker.backgroundColor = #colorLiteral(red: 0.4745098054, green: 0.8392156959, blue: 0.9764705896, alpha: 1)
            self.datePicker.datePickerMode = .dateAndTime
            calenderTF.inputView = self.datePicker
            
            // ToolBar
            let toolBar = UIToolbar()
            toolBar.barStyle = .default
            toolBar.isTranslucent = true
            toolBar.tintColor = UIColor(red: 92/255, green: 216/255, blue: 255/255, alpha: 1)
            toolBar.sizeToFit()
            
            // Adding Button ToolBar
            let doneButton = UIBarButtonItem(title: "Done", style: .plain, target: self, action: #selector(self.doneClick))
            
            let spaceButton = UIBarButtonItem(barButtonSystemItem: .flexibleSpace, target: nil, action: nil)
        
            toolBar.setItems([spaceButton, doneButton], animated: true)
            toolBar.isUserInteractionEnabled = true
            calenderTF.inputAccessoryView = toolBar
        }
    }
    
    @objc func doneClick() {
        let dateFormatter1 = DateFormatter()
        dateFormatter1.dateStyle = .medium
        dateFormatter1.timeStyle = .short
        calenderTF.text = dateFormatter1.string(from: datePicker.date)
        calenderTF.resignFirstResponder()

//        let reminderDate = datePicker.date
//        let dateComponents = Calendar.current.dateComponents(in: TimeZone.current, from:reminderDate)
//
//        AppDelegate.getAppDelegate().sendNotificationForCalender(withDate: dateComponents)
    }

    
    @IBAction func onSelectingTimerButton(_ sender: UIButton) {
        
        if let text = timerTF.text, let seconds = TimeInterval(text)  {
            AppDelegate.getAppDelegate().sendNotificationForTimer(withTimeInterval: seconds)
        }else {
            AppDelegate.getAppDelegate().sendNotificationForTimer(withTimeInterval: 3.0)
        }
    }
    
    @IBAction func onSelectingCalenderButton(_ sender: UIButton) {
        
        var reminderDate: Date!
        
        if let dp = self.datePicker {
            reminderDate = dp.date
        } else {
            reminderDate = Date.init(timeIntervalSinceNow: 60)
        }
        
        let dateComponents = Calendar.current.dateComponents([.day,.month,.hour,.minute], from: reminderDate)
//        dateComponents.second = 0
        
        AppDelegate.getAppDelegate().sendNotificationForCalender(withDate: dateComponents)
        
    }
    
    @IBAction func onSelectingLocationButton(_ sender: UIButton) {
        
        let region = CLCircularRegion.init(center: CLLocationCoordinate2D(latitude: 19.017614699999999, longitude: 72.856164399999997), radius: 500, identifier: "Mumbai")
        
        //Mumbai co-ordinate
        
//        CLLocationCoordinate2D
//            - latitude : 19.017614699999999
//        - longitude : 72.856164399999997
        

        CLService.shared.startUpdate(region: region)
        
    }

    private func setBackground(with bgColor: UIColor) {
        self.view.backgroundColor = bgColor
    }

}

extension ViewController: UITextFieldDelegate {
    
    func textFieldDidBeginEditing(_ textField: UITextField) {
        
        showPicker((textField == calenderTF))
        
        if textField == locationTF {
            stackViewTopConstraint.constant = -210
        } else {
            stackViewTopConstraint.constant = 0
        }
        self.view.layoutIfNeeded()
        
    }
    
    func textFieldShouldReturn(_ textField: UITextField) -> Bool {
        
        return true
    }
    
    func textFieldDidEndEditing(_ textField: UITextField) {

        if textField == locationTF {
            stackViewTopConstraint.constant = 0
        } else {
            stackViewTopConstraint.constant = 0
        }
        self.view.layoutIfNeeded()
    }
    
}

