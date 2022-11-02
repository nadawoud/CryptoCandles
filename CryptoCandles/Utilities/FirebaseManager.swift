//
//  FirebaseManager.swift
//  CryptoCandles
//
//  Created by Nada Yehia Dawoud on 02/11/2022.
//

import Foundation
import FirebaseAnalytics

class FirebaseManager {
    
    static let shared = FirebaseManager()
    
    private init() { }
    
    func logFirebaseAnalyticsEvent(title: String, description: String) {
        let uuid = UUID().uuidString
        Analytics.logEvent(AnalyticsEventSelectContent, parameters: [
          AnalyticsParameterItemID: "\(uuid)-\(title)",
          AnalyticsParameterItemName: title,
          AnalyticsParameterContentType: description,
        ])
    }
}
