//
//  DataManager.swift
//  AlamofireDemo
//
//  Created by  HE on 15/04/2020.
//  Copyright © 2020 computer science. All rights reserved.
//

import Foundation
import Alamofire
import SwiftyJSON


// MARK: - Staff data


/**
 This part is to manage staff data
 1) search  staff by keyword
 2) view all palyers ,return all palyer data
 3) view all other staff return all staff(excluded palyer) data
 4) insert a staff
 5) delete a staff by id
 6) modify staff info
 7)modify personal info
 8)view all staff ,return all staff data
 */

struct staff:Codable{
      var nationality: String?
      var name: String?
      var gender: String?
      var id: Int?
      var type: String?
      var email:String?
      var phone: String?
  }
  
 

///delete  a staff by its id
func deleteStaff(id:Int,completionHandler: @escaping (_ success: Bool) -> ()){
    let toDelete = ["id":id]
    AF.request("http://35.189.69.234/myclub/staff", method: .delete, parameters: toDelete,encoder: URLEncodedFormParameterEncoder(destination: .httpBody)).responseJSON(){response in
        switch response.result{
        case .success(let value):
            //get success signal from server
            print("delete result: \(value)")
            completionHandler(true)
        case .failure(let error):
            print(error)
            completionHandler(false)
        }}
    
}

///this method modify a staff by sending a staff object ， id cannot be modified
func modifyStaff(id:Int,name:String,gender:String,type:String,nationality:String,email:String,phone:String,completionHandler: @escaping (_ success: Bool) -> ()){
    let toModify:JSON = ["id":id,"name":name,"gender":gender,"typeString":type,"nationality":nationality,"email":email,"phone":phone]
    AF.request("http://35.189.69.234/myclub/staff", method: .put, parameters: toModify,encoder: URLEncodedFormParameterEncoder(destination: .httpBody)).responseJSON(){response in
            switch response.result{
            case .success(let value):
              //get success signal from server
                print("modify result: \(value)")
                completionHandler(true)
            case .failure(let error):
                print(error)
                completionHandler(false)
            }}
}


///this method also modift userdefault data,id cannot be modified
func editProfile(id:Int,name:String,gender:String,type:String,nationality:String,email:String,phone:String,completionHandler: @escaping (_ success: Bool) -> ()){
    let toModify:JSON = ["id":id,"name":name,"gender":gender,"typeString":type,"nationality":nationality,"email":email,"phone":phone]
    AF.request("http://35.189.69.234/myclub/staff", method: .put, parameters: toModify,encoder: URLEncodedFormParameterEncoder(destination: .httpBody)).responseJSON(){response in
        switch response.result{
        case .success(let value):
            //get success signal from server
            print("modify result: \(value)")
            UserDefaults.standard.set(type, forKey: "type")
            UserDefaults.standard.set(name, forKey: "name")
            UserDefaults.standard.set(id, forKey: "id")
            UserDefaults.standard.set(nationality, forKey: "nationality")
            UserDefaults.standard.set(gender, forKey: "gender")
            UserDefaults.standard.set(email, forKey: "email")
            UserDefaults.standard.set(phone, forKey: "phone")
            completionHandler(true)
        case .failure(let error):
            print(error)
            completionHandler(false)
        }}
}


///this method is to insert a new staff without id para
func insertStaff(name:String,gender:String,type:String,nationality:String,email:String,phone:String,completionHandler: @escaping (_ success: Bool) -> ()){
    let toInsert:JSON = ["name":name,"gender":gender,"typeString":type,"nationality":nationality,"email":email,"phone":phone]
         AF.request("http://35.189.69.234/myclub/staff", method: .post, parameters: toInsert,encoder: URLEncodedFormParameterEncoder(destination: .httpBody)).responseJSON(){response in
             switch response.result{
             case .success(let value):
               //get success signal from server
                 print("insertion result: \(value)")
                completionHandler(true)
             case .failure(let error):
                 print(error)
                completionHandler(false)
             }}
         
     }
           
///search staff by user input, return array might be empty
func searchStaff(keyword:String,completionHandler:@escaping ([staff]) -> Void){
    var staffArr:[staff] = []
    AF.request("http://35.189.69.234/myclub/staffs", method: .get, parameters: ["keyword":keyword],encoder: URLEncodedFormParameterEncoder(destination:  .methodDependent)).responseJSON(){response in
        switch response.result{
        case .success(let value):
            let json = JSON(value)
            for ( _,subJson):(String,JSON) in json["data"]["staff"]{
                //save all staff info into staffArr
                staffArr.append(staff(
                    //decode JSON
                    nationality: subJson["nationality"].string,
                    name: subJson["name"].string ,
                    gender: subJson["gender"].string,
                    id: subJson["id"].int,
                    type: subJson["type"].string,
                    email: subJson["email"].string,
                    phone: subJson["phone"].string))
            }
            statusInfo = json["statusInfo"].string
            print("statusInfo: \(statusInfo ?? "error get info")")
            completionHandler(staffArr)
        case .failure(let error):
            print(error)
            completionHandler(staffArr)
        }
    }
}

///use this  when the manager is taking attendance or choose staff of the attendendance  list for the new activity
func getAllStaff(completionHandler:@escaping ([staff]) -> Void){
   var staffArr:[staff] = []
   AF.request("http://35.189.69.234/myclub/staffs?keyword").responseJSON{ response in

       switch response.result{
          case .success(let value):
              let json = JSON(value)
              for ( _,subJson):(String,JSON) in json["data"]["staff"]{
                       //save all staff info into staffArr
                      staffArr.append(staff(
                      //decode JSON
                      nationality: subJson["nationality"].string,
                      name: subJson["name"].string ,
                      gender: subJson["gender"].string,
                      id: subJson["id"].int,
                      type: subJson["type"].string,
                      email: subJson["email"].string,
                      phone: subJson["phone"].string))
              }
           statusInfo = json["statusInfo"].string
           print("statusInfo: \(statusInfo ?? "error get info")")
           completionHandler(staffArr)
          case .failure(let error):
              print(error)
           completionHandler(staffArr)
          }
       }
      }



   
    ///use this when click 'view all player'
   func getAllplayer(completionHandler:@escaping ([staff]) -> Void){
    var staffArr:[staff] = []
    AF.request("http://35.189.69.234/myclub/staff/player").responseJSON{ response in

        switch response.result{
           case .success(let value):
               let json = JSON(value)
               for ( _,subJson):(String,JSON) in json["data"]["staff"]{
                        //save all staff info into staffArr
                       staffArr.append(staff(
                       //decode JSON
                       nationality: subJson["nationality"].string,
                       name: subJson["name"].string ,
                       gender: subJson["gender"].string,
                       id: subJson["id"].int,
                       type: subJson["type"].string,
                       email: subJson["email"].string,
                       phone: subJson["phone"].string))
               }
            statusInfo = json["statusInfo"].string
            print("statusInfo: \(statusInfo ?? "error get info")")
            completionHandler(staffArr)
           case .failure(let error):
               print(error)
            completionHandler(staffArr)
           }
        }
       }



///use this when click 'view other staff'
func getAllOtherStaff(completionHandler:@escaping ([staff]) -> Void){
    var staffArr:[staff] = []
    AF.request("http://35.189.69.234/myclub/staff/notPlayer").responseJSON{ response in
        switch response.result{
        case .success(let value):
            let json = JSON(value)
            for ( _,subJson):(String,JSON) in json["data"]["staff"]{
                //save all staff info into staffArr
                staffArr.append(staff(
                    //decode JSON
                    nationality: subJson["nationality"].string ,
                    name: subJson["name"].string  ,
                    gender: subJson["gender"].string ,
                    id: subJson["id"].int ,
                    type: subJson["type"].string ,
                    email: subJson["email"].string,
                    phone: subJson["phone"].string ))
            }
            statusInfo = json["statusInfo"].string
           print("statusInfo: \(statusInfo ?? "error get info")")
             completionHandler(staffArr)
        case .failure(let error):
            print(error)
            completionHandler(staffArr)
        }
        
    }
}
           
   
// MARK: - Activity data
/**
This part is to manage activity data
1) view 5 recent activities
2)search an activity by month
3) insert an activity
4) delete an activity by id
5) modify an activity
6) search an activity by date
7) get all activities
8) get all activities attended by a staff, para is staff id
*/

struct activity:Codable {
    var activityId:Int?
    var date:String?  ///yyyy/mm/dd time
    var name:String?
    var location:String?
    var type: String?
    var initiatorId: Int?  ///activity publisher id
    var initiatorName:String?
}

///  return 5 upcoming activities
func getRecentActivities(completionHandler:@escaping ([activity]) -> Void){
    var activityArr:[activity] = []
    let para:JSON = ["today":true,"number":5]
    AF.request("http://35.189.69.234/myclub/activity/search",method: .get,parameters: para).responseJSON{ response in
        switch response.result{
        case .success(let value):
            let json = JSON(value)
            for ( _,subJson):(String,JSON) in json["data"]["activity"]{
                //save all staff info into staffArr
                activityArr.append(activity(
                    //decode JSON
                    activityId: subJson["id"].int ,
                    date: subJson["time"].string  ,
                    name: subJson["name"].string ,
                    location: subJson["location"].string ,
                    type: subJson["type"].string ,
                    initiatorId: subJson["initiatorId"].int,
                    initiatorName: subJson["initiatorName"].string ))
            }
            statusInfo = json["statusInfo"].string
           print("statusInfo: \(statusInfo ?? "error get info")")
             completionHandler(activityArr)
        case .failure(let error):
            print(error)
            completionHandler(activityArr)
        }
        
    }
}

//search activities by month : month format is 2020/04
func searchActivityByMonth(month:String,completionHandler:@escaping ([activity]) -> Void){
    var activityArr:[activity] = []
    let para:JSON = ["month":month]
    AF.request("http://35.189.69.234/myclub/activity/search",method: .get,parameters: para).responseJSON{ response in
        switch response.result{
        case .success(let value):
            let json = JSON(value)
            for ( _,subJson):(String,JSON) in json["data"]["activity"]{
                //save all staff info into staffArr
                activityArr.append(activity(
                    //decode JSON
                    activityId: subJson["id"].int ,
                    date: subJson["time"].string  ,
                    name: subJson["name"].string ,
                    location: subJson["location"].string ,
                    type: subJson["type"].string ,
                    initiatorId: subJson["initiatorId"].int,
                    initiatorName: subJson["initiatorName"].string ))
            }
            statusInfo = json["statusInfo"].string
           print("statusInfo: \(statusInfo ?? "error get info")")
             completionHandler(activityArr)
        case .failure(let error):
            print(error)
            completionHandler(activityArr)
        }
        
    }
}

//search activities by date : date format is 2020/04/17
func searchActivityByDate(date:String,completionHandler:@escaping ([activity]) -> Void){
    var activityArr:[activity] = []
    let para:JSON = ["date":date]
    AF.request("http://35.189.69.234/myclub/activity/search",method: .get,parameters: para).responseJSON{ response in
        switch response.result{
        case .success(let value):
            let json = JSON(value)
            for ( _,subJson):(String,JSON) in json["data"]["activity"]{
                //save all staff info into staffArr
                activityArr.append(activity(
                    //decode JSON
                    activityId: subJson["id"].int ,
                    date: subJson["time"].string  ,
                    name: subJson["name"].string ,
                    location: subJson["location"].string ,
                    type: subJson["type"].string ,
                    initiatorId: subJson["initiatorId"].int,
                    initiatorName: subJson["initiatorName"].string ))
            }
            statusInfo = json["statusInfo"].string
           print("statusInfo: \(statusInfo ?? "error get info")")
             completionHandler(activityArr)
        case .failure(let error):
            print(error)
            completionHandler(activityArr)
        }
        
    }
}

//search activities that participated by a staff(use staff id)
func searchActParticipated(StaffID:Int,completionHandler:@escaping ([activity]) -> Void){
    var activityArr:[activity] = []
    let para:JSON = ["staffId":StaffID]
    AF.request("http://35.189.69.234/myclub/activity/search",method: .get,parameters: para).responseJSON{ response in
        switch response.result{
        case .success(let value):
            let json = JSON(value)
            for ( _,subJson):(String,JSON) in json["data"]["activity"]{
                //save all staff info into staffArr
                activityArr.append(activity(
                    //decode JSON
                    activityId: subJson["id"].int ,
                    date: subJson["time"].string  ,
                    name: subJson["name"].string ,
                    location: subJson["location"].string ,
                    type: subJson["type"].string ,
                    initiatorId: subJson["initiatorId"].int,
                    initiatorName: subJson["initiatorName"].string ))
            }
            statusInfo = json["statusInfo"].string
           print("statusInfo: \(statusInfo ?? "error get info")")
             completionHandler(activityArr)
        case .failure(let error):
            print(error)
            completionHandler(activityArr)
        }
        
    }
}

// get all activities
func getAllActivities(completionHandler:@escaping ([activity]) -> Void){
    var activityArr:[activity] = []
    AF.request("http://35.189.69.234/myclub/activity/search").responseJSON{ response in
        switch response.result{
        case .success(let value):
            let json = JSON(value)
            for ( _,subJson):(String,JSON) in json["data"]["activity"]{
                //save all staff info into staffArr
                activityArr.append(activity(
                    //decode JSON
                    activityId: subJson["id"].int ,
                    date: subJson["time"].string  ,
                    name: subJson["name"].string ,
                    location: subJson["location"].string ,
                    type: subJson["type"].string ,
                    initiatorId: subJson["initiatorId"].int,
                    initiatorName: subJson["initiatorName"].string ))
            }
            statusInfo = json["statusInfo"].string
           print("statusInfo: \(statusInfo ?? "error get info")")
             completionHandler(activityArr)
        case .failure(let error):
            print(error)
            completionHandler(activityArr)
        }
        
    }
}

//this method insert an activity without input activity id , date format is 2020/04/17 02:02
func insertActivity(name:String,initiatorName:String,initiatorId:Int,type:String,date:String,location:String,staffIds:[Int],completionHandler: @escaping (_ success: Bool) -> ()){
    let toInsert:JSON = ["name":name,"initiatorName":initiatorName,"typeString":type,"initiatorId":initiatorId,"time":date,"location":location,"staffIds":staffIds]
     AF.request("http://35.189.69.234/myclub/activity", method: .post, parameters: toInsert,encoder: URLEncodedFormParameterEncoder(destination: .httpBody)).responseJSON(){response in
         switch response.result{
         case .success(let value):
           //get success signal from server
             print("insertion result: \(value)")
            completionHandler(true)
         case .failure(let error):
             print(error)
            completionHandler(false)
         }}
 }

//delete an activity by its activityId
func deleteActivity(activityId:Int,completionHandler: @escaping (_ success: Bool) -> ()){
    AF.request("http://35.189.69.234/myclub/activity", method: .delete, parameters: ["id":activityId],encoder: URLEncodedFormParameterEncoder(destination: .httpBody)).responseJSON(){response in
         switch response.result{
         case .success(let value):
           //get success signal from server
             print("delete result: \(value)")
            completionHandler(true)
         case .failure(let error):
             print(error)
            completionHandler(false)
         }}
 }

//modify an activity ,activity id cannot be modified，date format is 2020/04/17 02:02
func modifyActivity(activityId:Int,name:String,initiatorName:String,initiatorId:Int,type:String,date:String,location:String,staffIds:[Int],completionHandler: @escaping (_ success: Bool) -> ()){
    let toModify:JSON = ["id":activityId,"name":name,"initiatorName":initiatorName,"typeString":type,"initiatorId":initiatorId,"time":date,"location":location,"staffIds":staffIds]
    AF.request("http://35.189.69.234/myclub/activity", method: .put, parameters: toModify,encoder: URLEncodedFormParameterEncoder(destination: .httpBody)).responseJSON(){response in
         switch response.result{
         case .success(let value):
           //get success signal from server
             print("modify result: \(value)")
            completionHandler(true)
         case .failure(let error):
             print(error)
            completionHandler(false)
         }}
 }


// MARK: - Attendance data
/**
This part is to manage record data
 type of state:Present, Absent,Leave,Injured,Applying,Waiting
1) view own attendance record  ,para is user id
2) apply for a leave ,para is  user id and activity id
3) edit attendance  record ,para is staff id,activity id and state
4) view the attendance table by activity id
5) view a certain attendance record by activity id and staff id
6) view leave application
7view attendance by staff id and month
*/

struct attendanceRec:Codable {
    var activityName:String?
    var date:String?
    var activityId:Int?
    var state:String?
    var staffId: Int?
    var staffName: String?
}

//use staff id and month to search attendance ,date format is 2020/04
func searchAttByMonth(staffId:Int,month:String,completionHandler:@escaping ([attendanceRec]) -> Void){
var attRecArr:[attendanceRec] = []
    let para:JSON = ["staffId":staffId,"month":month]
AF.request("http://35.189.69.234/myclub/attendance/search",method: .get,parameters: para).responseJSON{ response in
    switch response.result{
    case .success(let value):
        let json = JSON(value)
        for ( _,subJson):(String,JSON) in json["data"]["attendance"]{
            //save all staff info into staffArr
            attRecArr.append(attendanceRec(
                //decode JSON
                activityName: subJson["activityName"].string ,
                date: subJson["time"].string  ,
                activityId: subJson["activityId"].int ,
                state: subJson["state"].string ,
                staffId: subJson["staffId"].int ,
                staffName: subJson["staffName"].string))
        }
        statusInfo = json["statusInfo"].string
       print("statusInfo: \(statusInfo ?? "error get info")")
         completionHandler(attRecArr)
    case .failure(let error):
        print(error)
        completionHandler(attRecArr)
    }
  }
}


///search attendance records by an activity id   1）click an activity to display it  2）update activity to display attendance list
func searchAttByActId(activityId:Int,completionHandler:@escaping ([attendanceRec]) -> Void){
var attRecArr:[attendanceRec] = []
let para:JSON = ["activityId":activityId]
AF.request("http://35.189.69.234/myclub/attendance/search",method: .get,parameters: para).responseJSON{ response in
    switch response.result{
    case .success(let value):
        let json = JSON(value)
        debugPrint(json)
        for ( _,subJson):(String,JSON) in json["data"]["attendance"]{
            //save all staff info into staffArr
            attRecArr.append(attendanceRec(
                //decode JSON
                activityName: subJson["activityName"].string ,
                date: subJson["time"].string  ,
                activityId: subJson["activityId"].int ,
                state: subJson["state"].string ,
                staffId: subJson["staffId"].int ,
                staffName: subJson["staffName"].string))
        }
        statusInfo = json["statusInfo"].string
       print("statusInfo: \(statusInfo ?? "error get info")")
         completionHandler(attRecArr)
    case .failure(let error):
        print(error)
        completionHandler(attRecArr)
    }
  }
}


///search all attendance record of a specific staff by staff id  ,use when click ' view my attendance'
func searchAttByStaffId(staffId:Int,completionHandler:@escaping ([attendanceRec]) -> Void){
var attRecArr:[attendanceRec] = []
let para:JSON = ["staffId":staffId]
AF.request("http://35.189.69.234/myclub/attendance/search",method: .get,parameters: para).responseJSON{ response in
    switch response.result{
    case .success(let value):
        let json = JSON(value)
        for ( _,subJson):(String,JSON) in json["data"]["attendance"]{
            //save all staff info into staffArr
            attRecArr.append(attendanceRec(
                //decode JSON
                activityName: subJson["activityName"].string ,
                date: subJson["time"].string  ,
                activityId: subJson["activityId"].int ,
                state: subJson["state"].string ,
                staffId: subJson["staffId"].int ,
                staffName: subJson["staffName"].string))
        }
        statusInfo = json["statusInfo"].string
       print("statusInfo: \(statusInfo ?? "error get info")")
         completionHandler(attRecArr)
    case .failure(let error):
        print(error)
        completionHandler(attRecArr)
    }
  }
}

///For normal user ,click an activity and see if he/she is asked to attend the activity by the state returned . If the state is nil, then he/she is not going to attend the activity
func searchAttByStaffnActivityId(staffId:Int,activityId:Int,completionHandler:@escaping ([attendanceRec]) -> Void){
var attRecArr:[attendanceRec] = []
    let para:JSON = ["staffId":staffId,"activityId":activityId]
AF.request("http://35.189.69.234/myclub/attendance/search",method: .get,parameters: para).responseJSON{ response in
    switch response.result{
    case .success(let value):
        let json = JSON(value)
        for ( _,subJson):(String,JSON) in json["data"]["attendance"]{
            //save all staff info into staffArr
            attRecArr.append(attendanceRec(
                //decode JSON
                activityName: subJson["activityName"].string ,
                date: subJson["time"].string  ,
                activityId: subJson["activityId"].int ,
                state: subJson["state"].string ,
                staffId: subJson["staffId"].int ,
                staffName: subJson["staffName"].string))
        }
        statusInfo = json["statusInfo"].string
       print("statusInfo: \(statusInfo ?? "error get info")")
         completionHandler(attRecArr)
    case .failure(let error):
        print(error)
        completionHandler(attRecArr)
    }
  }
}
    

///  In the current month, leave >= 2 lead to application failure and return statusCode = 50
func applyForLeave(staffId:Int,activityId:Int,completionHandler: @escaping (_ success: Bool) -> ()){
    let toApply:JSON = ["staffId":staffId,"activityId":activityId,"stateString":"Applying"]
    AF.request("http://35.189.69.234/myclub/attendance", method: .put, parameters: toApply,encoder: URLEncodedFormParameterEncoder(destination: .httpBody)).responseJSON(){response in
        switch response.result{
        case .success(let value):
            let json = JSON(value)
            statusCode = json["statusCode"].int
            statusInfo = json["statusInfo"].string
            print("statusInfo: \(statusInfo ?? "error get info")")
            if(statusCode == 50){
                completionHandler(false)
            }else{
                completionHandler(true)
            }
        case .failure(let error):
            print(error)
            completionHandler(false)
        }}
}

///modify an  Attendance record by staff id ,activity id and state to change
func modifyAttRec(staffId:Int,activityId:Int,state:String,completionHandler: @escaping (_ success: Bool) -> ()){
    let toApply:JSON = ["staffId":staffId,"activityId":activityId,"stateString":state]
    AF.request("http://35.189.69.234/myclub/attendance", method: .put, parameters: toApply,encoder: URLEncodedFormParameterEncoder(destination: .httpBody)).responseJSON(){response in
        switch response.result{
        case .success(let value):
            let json = JSON(value)
            statusInfo = json["statusInfo"].string
            print("statusInfo: \(statusInfo ?? "error get info")")
            completionHandler(true)
        case .failure(let error):
            print(error)
            completionHandler(false)
        }}
}

///the manager can view all leave application
func viewLeaveApply(completionHandler:@escaping ([attendanceRec]) -> Void){
   var attRecArr:[attendanceRec] = []
    AF.request("http://35.189.69.234/myclub/attendance/search",method: .get,parameters: ["stateString":"Applying"]).responseJSON{ response in
    switch response.result{
    case .success(let value):
        let json = JSON(value)
        for ( _,subJson):(String,JSON) in json["data"]["attendance"]{
            //save all staff info into staffArr
            attRecArr.append(attendanceRec(
                //decode JSON
                activityName: subJson["activityName"].string ,
                date: subJson["time"].string  ,
                activityId: subJson["activityId"].int ,
                state: subJson["state"].string ,
                staffId: subJson["staffId"].int ,
                staffName: subJson["staffName"].string))
        }
        statusInfo = json["statusInfo"].string
       print("statusInfo: \(statusInfo ?? "error get info")")
         completionHandler(attRecArr)
    case .failure(let error):
        print(error)
        completionHandler(attRecArr)
    }
  }
}
    





// MARK: -  Transaction data

/**
This part is to manage wage data
1) view all transactions return all transactions
2) view transactions by date /month
3) delete a transaction by transaction id
4) insert a transaction
5) modify a transcation
*/

struct transaction:Decodable{
    var transactionId:Int?
    var name:String?
    var date:String?  ///yyyy/mm/dd
    var amount:Double?
    var description:String?
}


///return all transactions
func getAllTransactions(completionHandler:@escaping ([transaction]) -> Void){
        var transactionArr:[transaction] = []
        AF.request("http://35.189.69.234/myclub/transactions").responseJSON{ response in
            switch response.result{
            case .success(let value):
                let json = JSON(value)
                for ( _,subJson):(String,JSON) in json["data"]["transaction"]{
                    ///save all transactions info into transactionArr
                    transactionArr.append(
                        ///decode JSON
                        transaction(transactionId: subJson["id"].int,
                                    name: subJson["name"].string,
                                    date: subJson["time"].string,
                                    amount: subJson["amount"].double,
                                    description: subJson["description"].string))
                }
                statusInfo = json["statusInfo"].string
                print("statusInfo: \(statusInfo ?? "error get info")")
                completionHandler(transactionArr)
            case .failure(let error):
                print(error)
                completionHandler(transactionArr)
            }
            
        }
}


///search  transaction by specific date format is : 2020/04/17
func searchTransactionByDate(date:String,completionHandler:@escaping ([transaction]) -> Void){
    var transactionArr:[transaction] = []
    let para:JSON = ["date":date]
    AF.request("http://35.189.69.234/myclub/transaction/search",method: .get,parameters: para).responseJSON{ response in
        switch response.result{
        case .success(let value):
            let json = JSON(value)
           for ( _,subJson):(String,JSON) in json["data"]["transaction"]{
                ///save all transactions info into transactionArr
                transactionArr.append(
                    ///decode JSON
                    transaction(transactionId: subJson["id"].int,
                                name: subJson["name"].string,
                                date: subJson["time"].string,
                                amount: subJson["amount"].double,
                                description: subJson["description"].string))
            }
            statusInfo = json["statusInfo"].string
           print("statusInfo: \(statusInfo ?? "error get info")")
             completionHandler(transactionArr)
        case .failure(let error):
            print(error)
            completionHandler(transactionArr)
        }
        
    }
}

///search  transaction by month format is : 2020/04
func searchTransactionByMonth(date:String,completionHandler:@escaping ([transaction]) -> Void){
    var transactionArr:[transaction] = []
    let para:JSON = ["month":date]
    AF.request("http://35.189.69.234/myclub/transaction/search",method: .get,parameters: para).responseJSON{ response in
        switch response.result{
        case .success(let value):
            let json = JSON(value)
           for ( _,subJson):(String,JSON) in json["data"]["transaction"]{
                ///save all transactions info into transactionArr
                transactionArr.append(
                    ///decode JSON
                    transaction(transactionId: subJson["id"].int,
                                name: subJson["name"].string,
                                date: subJson["time"].string,
                                amount: subJson["amount"].double,
                                description: subJson["description"].string))
            }
            statusInfo = json["statusInfo"].string
           print("statusInfo: \(statusInfo ?? "error get info")")
             completionHandler(transactionArr)
        case .failure(let error):
            print(error)
            completionHandler(transactionArr)
        }
        
    }
}

//delete a transaction by its id
func deleteTransaction(transactionID:Int,completionHandler: @escaping (_ success: Bool) -> ()){
    AF.request("http://35.189.69.234/myclub/transaction", method: .delete, parameters:["id":transactionID],encoder: URLEncodedFormParameterEncoder(destination: .httpBody)).responseJSON(){response in
        switch response.result{
        case .success(let value):
            //get success signal from server
            print("delete result: \(value)")
            completionHandler(true)
        case .failure(let error):
            print(error)
            completionHandler(false)
        }}
}

//insert a transaction without id
func insertTransaction(date:String,name:String,amount:Double,description:String,completionHandler: @escaping (_ success: Bool) -> ()){
    let toInsert:JSON = ["time":date,"amount":amount,"name":name,"description":description]
    AF.request("http://35.189.69.234/myclub/transaction", method: .post,
    parameters:toInsert,encoder: URLEncodedFormParameterEncoder(destination: .httpBody)).responseJSON(){response in
                switch response.result{
                case .success(let value):
                  //get success signal from server
                    print("insert result: \(value)")
                    completionHandler(true)
                case .failure(let error):
                    print(error)
                    completionHandler(false)
                }}
}

//modify a transaction , id cannot be modified
func modifyTransaction(transactionId:Int,date:String,name:String,amount:Double,description:String,completionHandler: @escaping (_ success: Bool) -> ()){
    let toInsert:JSON = ["id":transactionId,"time":date,"amount":amount,"name":name,"description":description]
    AF.request("http://35.189.69.234/myclub/transaction", method: .put,
    parameters:toInsert,encoder: URLEncodedFormParameterEncoder(destination: .httpBody)).responseJSON(){response in
                switch response.result{
                case .success(let value):
                  //get success signal from server
                    print("modify result: \(value)")
                    completionHandler(true)
                case .failure(let error):
                    print(error)
                    completionHandler(false)
                }}
}

//MARK: Contract data
/**
 1) view own wage record , para is staff id
 2) search monthly wage , para is yyyy/mm and staff id
 3) delete a contract by contract id
 4) insert a contract
 5) modify a contract
 6) search a contract by keyword
 7) view all contracts ,return all contracts
 8)search a contract by staff id
 */



struct contract:Decodable {
    var contractId:Int?
    var startDate:String? /// yyyy/mm/dd
    var endDate:String?  /// yyyy/mm/dd
    var basicWage:Double?
    var bonus:Double?
    var staffName:String?
    var staffId:Int?
}


///delete a contract by contract id
func deleteContract(contractID:Int,completionHandler: @escaping (_ success: Bool) -> ()){
    AF.request("http://35.189.69.234/myclub/contract", method: .delete, parameters:["id":contractID],encoder: URLEncodedFormParameterEncoder(destination: .httpBody)).responseJSON(){response in
                switch response.result{
                case .success(let value):
                  //get success signal from server
                    print("insertion result: \(value)")
                    completionHandler(true)
                case .failure(let error):
                    print(error)
                    completionHandler(false)
                }}
            
        }

///insert a contract without contract id
func insertContract(staffID:Int,startDate:String,endDate:String,basicWage:Double,bonus:Double,completionHandler: @escaping (_ success: Bool) -> ()){
    let toInsert:JSON = ["staffId":staffID,"startDate":startDate,"endDate":endDate,"basicWage":basicWage,
        "bonus":bonus]
    AF.request("http://35.189.69.234/myclub/contract", method: .post,
    parameters:toInsert,encoder: URLEncodedFormParameterEncoder(destination: .httpBody)).responseJSON(){response in
                switch response.result{
                case .success(let value):
                  //get success signal from server
                    print("insertion result: \(value)")
                    completionHandler(true)
                case .failure(let error):
                    print(error)
                    completionHandler(false)
                }}
}

///modify a contract 
func modifyContract(contractID:Int,staffID:Int,startDate:String,endDate:String,basicWage:Double,bonus:Double,completionHandler: @escaping (_ success: Bool) -> ()){
    let toInsert:JSON = ["id":contractID,"staffID":staffID,"StartDate":startDate,"endDate":endDate,"basicWage":basicWage,
                         "bonus":bonus]
    AF.request("http://35.189.69.234/myclub/contract", method: .put, parameters: toInsert,encoder: URLEncodedFormParameterEncoder(destination: .httpBody)).responseJSON(){response in
        switch response.result{
        case .success(let value):
            //get success signal from server
            print("insertion result: \(value)")
            completionHandler(true)
        case .failure(let error):
            print(error)
            completionHandler(false)
        }}
}


//search a contract by staff id
func searchContractById(staffID:Int,completionHandler:@escaping ([contract]) -> Void){
    var contractArr:[contract] = []
    AF.request("http://35.189.69.234/myclub/contract", method: .get, parameters: ["staffId":staffID],encoder: URLEncodedFormParameterEncoder(destination:  .methodDependent)).responseJSON(){response in
        switch response.result{
        case .success(let value):
            let json = JSON(value)
               for ( _,subJson):(String,JSON) in json["data"]["contract"]{
                    // save all staff info into contractArr
                    contractArr.append(contract(
                        //decode JSON
                        contractId: subJson["id"].int,
                        startDate:  subJson["startDate"].string,
                        endDate: subJson["endDate"].string,
                        basicWage: subJson["basicWage"].double,
                        bonus:subJson["bonus"].double,
                        staffName: subJson["staffName"].string,
                        staffId: subJson["staffId"].int))
                }
            statusInfo = json["statusInfo"].string
            print("statusInfo: \(statusInfo ?? "error get info")")
            completionHandler(contractArr)
        case .failure(let error):
            print(error)
            completionHandler(contractArr)
        }
    }
}


///this method search a contract by user input ,search theory: name like
func searchContractByInput(keyword:String,completionHandler:@escaping ([contract]) -> Void){
    var contractArr:[contract] = []
    AF.request("http://35.189.69.234/myclub/contracts", method: .get, parameters: ["staffName":keyword],encoder: URLEncodedFormParameterEncoder(destination:  .methodDependent)).responseJSON(){response in
        switch response.result{
        case .success(let value):
            let json = JSON(value)
            debugPrint(json)
            for ( _,subJson):(String,JSON) in json["data"]["contract"]{
                // save all staff info into contractArr
                contractArr.append(contract(
                    //decode JSON
                    contractId: subJson["id"].int,
                    startDate:  subJson["startDate"].string,
                    endDate: subJson["endDate"].string,
                    basicWage: subJson["basicWage"].double,
                    bonus:subJson["bonus"].double,
                    staffName: subJson["staffName"].string,
                    staffId: subJson["staffId"].int))
            }
            statusInfo = json["statusInfo"].string
            print("statusInfo: \(statusInfo ?? "error get info")")
            completionHandler(contractArr)
        case .failure(let error):
            print(error)
            completionHandler(contractArr)
        }
    }
}

func getAllContracts(completionHandler:@escaping ([contract]) -> Void){
    var contractArr:[contract] = []
    AF.request("http://35.189.69.234/myclub/contracts",method: .get,parameters: ["staffName":""]).validate().responseJSON{ response in
        switch response.result{
        case .success(let value):
            let json = JSON(value)
            for ( _,subJson):(String,JSON) in json["data"]["contract"]{
                contractArr.append(contract(
                    //decode JSON
                    contractId: subJson["id"].int,
                    startDate:  subJson["startDate"].string,
                    endDate: subJson["endDate"].string,
                    basicWage: subJson["basicWage"].double,
                    bonus:subJson["bonus"].double,
                    staffName: subJson["staffName"].string,
                    staffId: subJson["staffId"].int))
            }
            statusInfo = json["statusInfo"].string
            print("statusInfo: \(statusInfo ?? "error get info")")
            completionHandler(contractArr)
        case .failure(let error):
            print(error)
            completionHandler(contractArr)
        }
    }
}


//MARK: Wage Data
/**
 1) get wage data of current month, para is staff id
 2)search wage by month and staff id
 3)get wage table of current month
 */

struct monthlyWage:Decodable {
    var total:Double?
    var bonus:Double?
    var basicWage:Double?
    var leaveTime:Int?
    var absentTime:Int?
    var presentTime:Int?
    var staffName:String?
    var staffId:Int?
}


///get  wage of current month
func getCurMonthWage(staffId:Int,completionHandler:@escaping (monthlyWage) -> Void){
    let para:JSON = ["staffId":staffId]
    AF.request("http://35.189.69.234/myclub/salary", method: .get, parameters:para ,encoder: URLEncodedFormParameterEncoder(destination: .methodDependent)).responseJSON(){response in
        var wageInfo:monthlyWage
        switch response.result{
        case .success(let value):
            let json = JSON(value)
            
            wageInfo = monthlyWage(total: json["data"]["total"].double,
                                   bonus: json["data"]["bonus"].double,
                                   basicWage: json["data"]["basicWage"].double,
                                   leaveTime: json["data"]["leaveTime"].int,
                                   absentTime: json["data"]["absentTime"].int,
                                   presentTime: json["data"]["presentTime"].int)
            statusInfo = json["statusInfo"].string
            print("statusInfo: \(statusInfo ?? "error get info")")
            completionHandler(wageInfo)
        case .failure(let error):
            print(error)
        }
    }
}

///search staff wage of a specific month ,month format is 2020/04
func searchMonthlyWage(staffId:Int,month:String,completionHandler:@escaping (monthlyWage) -> Void){
    let para:JSON = ["staffId":staffId,"month":month]
    AF.request("http://35.189.69.234/myclub/salary", method: .get, parameters:para ,encoder: URLEncodedFormParameterEncoder(destination:  .methodDependent)).responseJSON(){response in
        var wageInfo:monthlyWage
        switch response.result{
        case .success(let value):
            let json = JSON(value)
            wageInfo = monthlyWage(total: json["data"]["total"].double,
                                   bonus: json["data"]["bonus"].double,
                                   basicWage: json["data"]["basicWage"].double,
                                   leaveTime: json["data"]["leaveTime"].int,
                                   absentTime: json["data"]["absentTime"].int,
                                   presentTime: json["data"]["presentTime"].int)
            statusInfo = json["statusInfo"].string
            print("statusInfo: \(statusInfo ?? "error get info")")
            completionHandler(wageInfo)
        case .failure(let error):
            print(error)
        }
    }
}



///get wage table of current month
func getAllWage(completionHandler:@escaping ([monthlyWage]) -> Void){
    var wageArr:[monthlyWage] = []
    AF.request("http://35.189.69.234/myclub/salary/all", method: .get).responseJSON(){response in
        switch response.result{
        case .success(let value):
            let json = JSON(value)
            for ( _,subJson):(String,JSON) in json["data"]["salary"]{
                // save all staff info into contractArr
                wageArr.append(monthlyWage(
                total: subJson["total"].double,
                bonus: subJson["bonus"].double,
                basicWage: subJson["basicWage"].double,
                leaveTime: subJson["leaveTime"].int,
                absentTime: subJson["absentTime"].int,
                presentTime: subJson["presentTime"].int,
                staffName: subJson["staffName"].string,
                staffId: subJson["staffId"].int
                ))
            }
            statusInfo = json["statusInfo"].string
            print("statusInfo: \(statusInfo ?? "error get info")")
            completionHandler(wageArr)
        case .failure(let error):
            print(error)
            completionHandler(wageArr)
        }
    }
}

