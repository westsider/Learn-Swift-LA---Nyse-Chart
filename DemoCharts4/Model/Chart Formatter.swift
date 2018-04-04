//
//  Chart Formatter.swift
//  DemoCharts4
//
//  Created by Warren Hansen on 4/4/18.
//  Copyright © 2018 Warren Hansen. All rights reserved.
//

import Foundation
import Charts

public class DateValueFormatter: NSObject, IAxisValueFormatter {
    private let dateFormatter = DateFormatter()
    
    override init() {
        super.init()
        dateFormatter.dateFormat = "dd MMM HH:mm"
    }
    
    public func stringForValue(_ value: Double, axis: AxisBase?) -> String {
        return dateFormatter.string(from: Date(timeIntervalSince1970: value))
    }
}

class ChartStringFormatter: NSObject, IAxisValueFormatter {
    
    var nameValues: [String] =  []
    
    public func stringForValue(_ value: Double, axis: AxisBase?) -> String {
        return String(describing: nameValues[Int(value)])
    }
}
