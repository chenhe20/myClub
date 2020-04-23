//
//  Validation.swift
//  AlamofireDemo
//
//  Created by  HE on 17/04/2020.
//  Copyright © 2020 computer science. All rights reserved.
//

import Foundation

func validateUsernameInput(username:String) -> Bool{
   // Length be 15 characters max and 1 characters minimum, you can always modify.
        let usernameRegex = "^\\w{1,15}$"
        let trimmedString = username.trimmingCharacters(in: .whitespaces)
        let validateUserame = NSPredicate(format: "SELF MATCHES %@", usernameRegex)
        let isValidateUsername = validateUserame.evaluate(with: trimmedString)
        return isValidateUsername
}

func validatePasswordInput(password:String) -> Bool{
     // Length be 30 characters max and 1 characters minimum, you can always modify.
          let passwordRegex = "^\\w{1,30}$"
          let trimmedString = password.trimmingCharacters(in: .whitespaces)
          let validatePassword = NSPredicate(format: "SELF MATCHES %@", passwordRegex)
          let isValidatePassword = validatePassword.evaluate(with: trimmedString)
          return isValidatePassword
}

func validateIDInput(staffID:String) -> Bool{
    // length be exactly 10 interger 
     let staffidIDRegex = "^\\d{10}$"
          let trimmedString = staffID.trimmingCharacters(in: .whitespaces)
          let validateStaffID = NSPredicate(format: "SELF MATCHES %@", staffidIDRegex)
          let isValidStaffID = validateStaffID.evaluate(with: trimmedString)
          return isValidStaffID
}

func validateLocationInput(location:String) -> Bool{
     // Length be 50 characters max and 1 characters minimum, you can always modify.
          let locationRegex = "^\\w{1,50}$"
          let trimmedString = location.trimmingCharacters(in: .whitespaces)
          let validateLocation = NSPredicate(format: "SELF MATCHES %@", locationRegex)
          let isValidateLocation = validateLocation.evaluate(with: trimmedString)
          return isValidateLocation
}

func validateEmailInput(email:String) -> Bool{
     // Length be 50 characters max and 1 characters minimum with email format, you can always modify.
          let emailRegex = "[A-Z0-9a-z._%+-]+@[A-Za-z0-9.-]+\\.[A-Za-z]{2,50}"
          let trimmedString = email.trimmingCharacters(in: .whitespaces)
          let validateEmail = NSPredicate(format: "SELF MATCHES %@", emailRegex)
          let isValidateEmail = validateEmail.evaluate(with: trimmedString)
          return isValidateEmail
}

func validatePhoneInput(phone:String) -> Bool{
     // 11 integer exactly
          let phoneRegex = "^\\d{11}$"
          let trimmedString = phone.trimmingCharacters(in: .whitespaces)
          let validatePhone = NSPredicate(format: "SELF MATCHES %@", phoneRegex)
          let isValidatePhone = validatePhone.evaluate(with: trimmedString)
          return isValidatePhone
}

func validateYear(yearInput:String) -> Bool{
    var validate = false
    if (yearInput.count == 4){
        if let year = Int(yearInput){
            validate = (year > 2019 && year < 2025)
        }
    }
    return validate
}

func validateMonth(monthInput:String) -> Bool{
    var validate = false
       if (monthInput.count <= 2 && monthInput.count >= 0){
           if let month = Int(monthInput){
               validate = (month > 0 && month < 13)
           }
       }
       return validate
}

func validateDate(dateInput:String) ->Bool{
    var validate = false
    if (dateInput.count <= 2 && dateInput.count >= 0){
        if let date = Int(dateInput){
            validate = (date > 0 && date < 32 )
        }
    }
    return validate
}

func validateTime(time:String) -> Bool{
     // hour:min
          let timeRegex = "^([0-9]|0[0-9]|1[0-9]|2[0-3]):[0-5][0-9]$"
          let trimmedString = time.trimmingCharacters(in: .whitespaces)
          let validateTime = NSPredicate(format: "SELF MATCHES %@", timeRegex)
          let isValidateTime = validateTime.evaluate(with: trimmedString)
          return isValidateTime
}

   

