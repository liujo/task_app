//
//  GlobalTimer.swift
//  Task app
//
//  Created by Joseph Liu on 17.03.17.
//  Copyright © 2017 Joseph Liu. All rights reserved.
//

import Foundation

class GlobalTimer {
    
    static let sharedInstance = GlobalTimer()
    private init() { }
    
    private var timer = Timer()
    
    func startTimer() {
        
        refreshApp()
        
        //here i set up the timer in a way that it goes off exactly at the beginning of each minute
        var calendar1 = Calendar.autoupdatingCurrent
        calendar1.locale = Locale.autoupdatingCurrent
        var dateComps = calendar1.dateComponents(in: .autoupdatingCurrent, from: Date())
        let difference = 60 - dateComps.second!
        
        timer.invalidate()
        timer = Timer.scheduledTimer(timeInterval: TimeInterval(difference), target: self, selector: #selector(fireAccurateTimer), userInfo: nil, repeats: false)
        
    }
    
    @objc private func fireAccurateTimer() {
        
        refreshApp()
        
        timer.invalidate()
        timer = Timer.scheduledTimer(timeInterval: 60, target: self, selector: #selector(refreshApp), userInfo: nil, repeats: true)
        
    }
    
    @objc private func refreshApp() {
        
        let notificationName = Notification.Name(StaticStrings.refreshMainVCNotificationIdentifier)
        NotificationCenter.default.post(name: notificationName, object: nil)

    }
    
}
