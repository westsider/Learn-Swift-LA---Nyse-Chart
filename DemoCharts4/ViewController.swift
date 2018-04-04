//
//  ViewController.swift
//  DemoCharts4
//
//  Created by Warren Hansen on 4/4/18.
//  Copyright © 2018 Warren Hansen. All rights reserved.
//

import UIKit
import Charts

class ViewController: UIViewController {

    @IBOutlet weak var chtChart: LineChartView!
    
    override func viewDidLoad() {
        super.viewDidLoad()
      
        Alpha.getPricesFor(ticker: "SPY", debug: true) { (response) in
            if let nyseData = response as?  [(date:Date, close:Double)] {
                for each in nyseData {
                    print("\(each.date) \(each.close)")
                    self.updateGraph(data: nyseData)
                }
            }
        }
    }

    func updateGraph(data:[(date:Date, close:Double)]) {
        
        DispatchQueue.main.async {
            var lineChartEntry = [ChartDataEntry]()
            let xAxis = self.chtChart.xAxis
            xAxis.labelPosition = .bottomInside
            xAxis.drawGridLinesEnabled = false
            let formatter = ChartStringFormatter()
            let dateArray = data.map { $0.date}
            let dateStrArr = dateArray.map { value in Utilities.convertToStringNoTimeFrom(date: value) }
            
            // convert double x axis to string
            formatter.nameValues = dateStrArr
            xAxis.valueFormatter = formatter
            
            for (i, each) in data.enumerated() {
                let value = ChartDataEntry(x: Double(i), y: each.close)
                lineChartEntry.append(value)
            }
            
            let line1 = LineChartDataSet(values: lineChartEntry, label: "close" )
            line1.colors =  [NSUIColor.darkGray]
            line1.drawCirclesEnabled = false
            line1.drawFilledEnabled = true
            let gradientColors = [ #colorLiteral(red: 0.1298420429, green: 0.1298461258, blue: 0.1298439503, alpha: 1), UIColor.clear.cgColor] as CFArray // Colors of the gradient
            let colorLocations:[CGFloat] = [1.0, 0.0] // Positioning of the gradient
            let gradient = CGGradient.init(colorsSpace: CGColorSpaceCreateDeviceRGB(), colors: gradientColors, locations: colorLocations) // Gradient Object
            line1.fill = Fill.fillWithLinearGradient(gradient!, angle: 90.0)
            
            let data = LineChartData()
            data.addDataSet(line1)
            self.chtChart.data = data
            self.chtChart.chartDescription?.text = "Daily Price Data"
            self.chtChart.leftAxis.enabled = false
            self.chtChart.animate(xAxisDuration: 2.5)
        }
      
    }
    


}

