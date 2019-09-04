//
//  File.swift
//  Todoey
//
//  Created by Haikal on 4/9/19.
//  Copyright © 2019 Haikal Rosman. All rights reserved.
//

import Foundation

class Item: Codable {
    
    var title: String = ""
    var isDone: Bool = false
    
    convenience init(title: String) {
        self.init()
        self.title = title
    }
    
    convenience init(title: String, isDone: Bool) {
        self.init()
        self.title = title
        self.isDone = isDone
    }
    
}
