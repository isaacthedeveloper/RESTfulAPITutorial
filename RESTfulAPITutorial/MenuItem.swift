//
//  MenuItem.swift
//  RESTfulAPITutorial
//
//  Created by Isaac Ballas on 2019-12-20.
//  Copyright © 2019 Isaac Ballas. All rights reserved.
//

import Foundation
/// The highest level of information returned by the API is a key called `items` that contains an array of all of the menu items in JSON format. Because of this, you will need an intermediary `MenuItems` object that conforms to `Codable` and has a property called `items` so that the JSON data can be decoded properly. You can then access the array of items through this object.

/// The API can also be used to return a list of categories. This list is an array of strings under the key `categories`. Similar to decoding the data that contains menu items, you will need an intermediate object. In this case it will be `Categories` and should have a property called `catefories` of type [String].

/// Yoou also need a model of the value that comes with `preparation_time`. This is returned from the /order endpoint and represents the amount of time until an order is ready. Since the key in JSON uses an underscore, you should create a custom key so your property can be named according to proper swift convention.
struct MenuItem: Codable {
    var id: Int
    var name: String
    var detailText: String
    var price: Double
    var category: String
    var imageURL: URL
    
    enum CodingKeys: String, CodingKey {
        case id
        case name
        case detailText = "description"
        case price
        case category
        case imageURL = "image_url"
    }
    
    
}


struct MenuItems: Codable {
    let items: [MenuItem]
}


struct Categories: Codable {
    let categories: [String]
}

struct PreparationTime: Codable {
    let prepTime: Int
    
    enum CodingKeys: String, CodingKey {
        case prepTime = "preparation_time"
    }
}

/// The order model object will contain a list of the items the user has added.
struct Order: Codable {
    var menuItems: [MenuItem]
    
    init(menuItems: [MenuItem] = []) {
        self.menuItems = menuItems
    }
}
