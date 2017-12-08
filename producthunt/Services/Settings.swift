//
//  Settings.swift
//  producthunt
//
//  Created by Chung Tran on 08/12/2017.
//  Copyright © 2017 Chung Tran. All rights reserved.
//

import Foundation

class Setting {
    static var currentTopicSlug: String {
        get {
            if let current = UserDefaults.standard.string(forKey: "CurrentTopicSlug") {
                return current
            }
            self.currentTopicSlug = "tech"
            return "tech"
        }
        
        set {
            print("[Settings] change current currency to \(newValue)")
            UserDefaults.standard.set(newValue, forKey: "CurrentTopicSlug")
            //            NotificationCenter.default.post(name: NSNotification.Name(rawValue: CurrentCurrencyDidChangeNotification), object: currentCurrency)
        }
    }
}
