//
//  Person.swift
//  NameToFaces
//
//  Created by Logesh Palani on 26/08/21.
//

import UIKit

class Person: NSObject, Codable {
    var name: String
    var imageName: String
    init(name: String, imageName: String) {
        self.name = name
        self.imageName = imageName
    }
}

//class Person: NSObject, NSCoding {
//    var name: String
//    var imageName: String
//    init(name: String, imageName: String) {
//        self.name = name
//        self.imageName = imageName
//    }
//    required init(coder aDecoder: NSCoder) {
//        name = aDecoder.decodeObject(forKey: "name") as? String ?? ""
//        imageName = aDecoder.decodeObject(forKey: "image") as? String ?? ""
//    }
//    func encode(with aCoder: NSCoder) {
//        aCoder.encode(name, forKey: "name")
//        aCoder.encode(imageName, forKey: "image")
//    }
//}
