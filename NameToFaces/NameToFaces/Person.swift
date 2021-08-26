//
//  Person.swift
//  NameToFaces
//
//  Created by Logesh Palani on 26/08/21.
//

import UIKit

class Person: NSObject {
    var name: String
    var imageName: String
    init(name: String, imageName: String) {
        self.name = name
        self.imageName = imageName
    }
}
