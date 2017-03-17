//
//  SettingsTableViewController.swift
//  Task app
//
//  Created by Joseph Liu on 13.03.17.
//  Copyright © 2017 Joseph Liu. All rights reserved.
//

import UIKit

class SettingsTableViewController: UITableViewController {

    let defaults = UserDefaults.standard
    
    @IBOutlet weak var sortTasksByLabel: UILabel!
    @IBOutlet weak var notificationsSwitch: UISwitch!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        notificationsSwitch.isOn = defaults.bool(forKey: StaticStrings.receiveNotificationsDefaulsKey)
        
        
    }
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(true)
        
        sortTasksByLabel.text = defaults.string(forKey: StaticStrings.sortTasksUserDefaultsKey)
    }

    @IBAction func doneButtonAction(_ sender: Any) {
        
        self.dismiss(animated: true, completion: nil)
        
    }
    
    @IBAction func notificationsSwitchAction(_ sender: UISwitch) {
        
        defaults.set(sender.isOn, forKey: StaticStrings.receiveNotificationsDefaulsKey)
        if sender.isOn == false {
            Notifications.sharedInstance.cancelAllNotifications()
        }
        
    }
    

}
