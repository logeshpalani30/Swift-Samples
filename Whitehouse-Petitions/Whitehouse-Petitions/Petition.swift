//
//  Petition.swift
//  Swift-Samples
//
//  Created by Logesh Palani on 20/08/21.
//

import Foundation

struct Petition: Codable {
    var title: String
    var body: String
    var signatureCount: Int
}
