//
//  Date Utility.swift
//  DemoCharts4
//
//  Created by Warren Hansen on 4/4/18.
//  Copyright © 2018 Warren Hansen. All rights reserved.
//

import Foundation

class Utilities {
    
    class func convertToDateFrom(string: String, debug: Bool)-> Date? {
        let formatter = DateFormatter()
        if ( debug ) { print("\ndate string: \(string)") }
        let dateS = string
        formatter.dateFormat = "yyyy/MM/dd"
        if let date:Date = formatter.date(from: dateS) {
            if ( debug ) { print("Convertion to Date: \(date)\n") }
            return date
        } else {
            return formatter.date(from: "1900/01/01")
        }
    }
    
    class func convertToStringNoTimeFrom(date: Date)-> String {
        let formatter = DateFormatter()
        formatter.dateFormat = "MM/dd/yy"
        formatter.timeZone = TimeZone(secondsFromGMT: 0)
        return formatter.string(from: date)
    }
}
