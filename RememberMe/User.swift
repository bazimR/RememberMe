//
//  User.swift
//  RememberMe
//
//  Created by Rishal Bazim on 05/04/25.
//

import Foundation
import SwiftData

@Model
class User {
    var name: String
    @Attribute(.externalStorage) var photo: Data

    init(name: String, photo: Data) {
        self.name = name
        self.photo = photo
    }
}
