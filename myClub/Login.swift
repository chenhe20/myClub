//
//  Login.swift
//  AlamofireDemo
//
//  Created by  HE on 15/04/2020.
//  Copyright © 2020 computer science. All rights reserved.
//

import Foundation
import Alamofire
import SwiftyJSON
var user:staff?
var LOGIN_STATE:Bool?
var statusCode:Int?
var statusInfo:String?

/**
 First check if the user is logged in
      If it is the login state,retrive  data from user defaults
      If  not logged in, enter the username and password
      You can check the legality of the user name and password first
       Send login request after verification
        if Fail input again
        If successful, get the user's personal information, store the user information locally, and change the login status to already logged in. next time user starts the app dont have to login again
    After successful login, the user's information will be obtained from server. The content will be displayed according to the user type. The personal home page will be displayed according to the user information.
 */

/**
 When  clicks the registration button to register
 user needs to enter the username password and the ID on the ID card assigned by the club
 If the registration is successful,
 automatically log in but s personal information is all nil
 */

/**
 statuscode is used for if sentence
 statusinfo is used to send notifications to users
 Status code 20  successful login or registration;
 40 user name already exists during registration;
 41 account or password is incorrect;
 42 invalid id;
 43 id has been bound
 */


///LOGIN
func loginRequest(username:String, passwords:String,completionHandler: @escaping (_ success: Bool) -> ()) {
    
    let params: [String: String] = ["username": username,"password": passwords]
    
    AF.request("http://35.189.69.234/myclub/login", method: .post, parameters: params,encoder: URLEncodedFormParameterEncoder(destination: .httpBody)).responseJSON {
        response in
        switch response.result{
        case .success(let value):
            let json = JSON(value)
            statusCode = json["statusCode"].int
            ///status code , login successfully
            if (statusCode == 20 ){
                print("successfully login")
                ///store user data and pass it to var user
                user = staff(nationality: json["data"]["staff"]["nationality"].string,
                             name: json["data"]["staff"]["name"].string ,
                             gender: json["data"]["staff"]["gender"].string ,
                             id: json["data"]["staff"]["id"].int ,
                             type: json["data"]["staff"]["type"].string ,
                             email: json["data"]["staff"]["email"].string ,
                             phone: json["data"]["staff"]["phone"].string)
                ///store data locally and set loginstate to true, no need login next time opens the app
                print("succussfully get user data")
                UserDefaults.standard.set(true, forKey: "LOGIN_STATE")
                UserDefaults.standard.set(user?.type, forKey: "type")
                UserDefaults.standard.set(user?.name, forKey: "name")
                UserDefaults.standard.set(user?.id, forKey: "id")
                UserDefaults.standard.set(user?.nationality, forKey: "nationality")
                UserDefaults.standard.set(user?.gender, forKey: "gender")
                UserDefaults.standard.set(user?.email, forKey: "email")
                UserDefaults.standard.set(user?.phone, forKey: "phone")
                print("successfully save user data")
                completionHandler(true)
            }else{
                statusInfo = json["statusInfo"].string
                print("statusCode: \(statusCode!)")
                print("statusInfo: \(statusInfo!)")
                ///login state is not logged in
                UserDefaults.standard.set(false, forKey: "LOGIN_STATE")
                completionHandler(false)
            }
                
                
            case .failure(let error):
                print(error)
             completionHandler(false)
            }}
        
        
        
}


///SIGN IN
func signUpRequest(username:String, passwords:String,ID: Int, completionHandler: @escaping (_ success: Bool) -> ()) {
    
    let params:JSON = ["username": username,"password": passwords,"staffId":ID]
    AF.request("http://35.189.69.234/myclub/signup", method: .post, parameters: params,encoder: URLEncodedFormParameterEncoder(destination: .httpBody)).responseJSON {
        response in
        switch response.result{
        case .success(let value):
            let json = JSON(value)
            statusCode = json["statusCode"].int
            if(statusCode == 20){
                print("connected")
                ///statuscode is 20 sign up successfully and automatically login
                UserDefaults.standard.set(true, forKey: "LOGIN_STATE")
                UserDefaults.standard.set(ID, forKey: "id")
                completionHandler(true)
            }else{
                statusInfo = json["statusInfo"].string
                 print("statusCode: \(statusCode!)")
                 print("statusInfo: \(statusInfo!)")
                completionHandler(false)
            }
        case .failure(let error):
            print(error)
             completionHandler(false)
        }}
}
   



    
    
