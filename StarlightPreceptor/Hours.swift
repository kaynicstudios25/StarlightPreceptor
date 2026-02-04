//
//  File.swift
//  MyFirstProject
//
//  Created by Kaylyn Groom on 2/3/26.
//

import Foundation
import SwiftData

@Model
class Hours {
    var student_name: String
    var date: Date
    var hours: Int
    
    init(student_name: String, date: Date, hours: Int) {
        self.student_name = student_name
        self.date = date
        self.hours = hours
    }
    
    
    
}
