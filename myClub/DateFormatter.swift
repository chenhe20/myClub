//
//  DateFormatter.swift
//  AlamofireDemo
//
//  Created by  HE on 18/04/2020.
//  Copyright © 2020 computer science. All rights reserved.
//

import Foundation

/*
 These two methods are only used when there is a display requirement
  Don't use these two methods to modify the data
 1）2020/04/17 to Apr 17 2020
 2）2020/04/17 02:02(or 2020/04/17 02:02:02T0000) to Apr 17 2020 02:02
 **/


// convert numeric month to its name
func numToMonth(num:String) -> String{
switch num {
case "01": return "Jan"
case "02": return "Feb"
case "03": return "Mar"
case "04": return "Apr"
case "05": return "May"
case "06": return "Jun"
case "07": return "Jul"
case "08": return "Aug"
case "09": return "Sep"
case "10": return "Oct"
case "11": return "Nov"
case "12": return "Dec"
default: return " "
 }
}

///to display date with detailed time : 2020/04/17 02:02（or longer） -> Apr 17 2020 02:02
    func detailedTimeFormatter(date:String) -> String{
        let year = (date as NSString).substring(to: 4)
        var month = (date as NSString).substring(with: NSRange(location: 5, length: 2))
            month = numToMonth(num: month)
        let day = (date as NSString).substring(with: NSRange(location: 8, length: 2))
        let time = (date as NSString).substring(with: NSRange(location: 11, length: 5))
        return month + " " + day + " " + year + " " + time

    }
///to display date without detailed time  2020/04/17 ->  Apr 17 2020
    func timeFormatter(date:String) -> String{
        let year = (date as NSString).substring(to: 4)
        var month = (date as NSString).substring(with: NSRange(location: 5, length: 2))
            month = numToMonth(num: month)
        let day = (date as NSString).substring(with: NSRange(location: 8, length: 2))
        return month + " " + day + " " + year
    }

