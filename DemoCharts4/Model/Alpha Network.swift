//
//  Alpha Network.swift
//  DemoCharts4
//
//  Created by Warren Hansen on 4/4/18.
//  Copyright © 2018 Warren Hansen. All rights reserved.
//

import Foundation

class Alpha {
    
    class func getPricesFor(ticker:String, debug:Bool, callback: @escaping (Array<AnyObject>) -> ()) {
        
        let alphaApiKey = "your-API-Key"
        
        guard let url = URL(string: "https://www.alphavantage.co/query?function=TIME_SERIES_DAILY&symbol=\(ticker)&apikey=\(alphaApiKey)") else { return }
        let request = URLRequest(url: url)
        let task = URLSession.shared.dataTask(with: request) { data, response, error in
            
            guard let data = data else {
                print("\(error.debugDescription)")
                return
            }
            
            guard let json = (try? JSONSerialization.jsonObject(with: data, options: JSONSerialization.ReadingOptions.mutableContainers)) as? [String: Any] else {
                print("Big problems with json serialization")
                return
            }
            
            var priceArry:[(date:Date, close:Double)] = []
            guard let time = json["Time Series (Daily)"] as? NSDictionary else { return }
            
            for (key, value) in time {
                guard let stringDate:String = key as? String  else { return }
                guard let date = Utilities.convertToDateFrom(string: stringDate, debug: false) else { return }
                guard let value = value as? Dictionary<String, String>  else { return }
                guard let close = value["4. close"] else { return }
                let closeDouble = (close as NSString).doubleValue
                priceArry.append((date: date , close: closeDouble))
            }
            
            let dateSort = priceArry.sorted(by: {$0.date < $1.date})
            
            if debug {
                for each in dateSort {
                    print("\(each.date) \t\(each.close)")
                }
            }
            callback(dateSort as Array<AnyObject>)
        }
        task.resume()
    }
}
