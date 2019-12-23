//
//  ServerData.swift
//  RESTfulAPITutorial
//
//  Created by Isaac Ballas on 2019-12-20.
//  Copyright © 2019 Isaac Ballas. All rights reserved.
//

/*:
 Data Received From Server
 {
     "items": [
         {
             "category": "entrees",
             "description": "Seasoned meatballs on top of freshly-made spaghetti. Served with a robust tomato sauce.",
             "price": 9,
             "image_url": "http://localhost:8090/images/1.png",
             "id": 1,
             "name": "Spaghetti and Meatballs"
         },
         {
             "category": "entrees",
             "description": "Tomato sauce, fresh mozzarella, basil, and extra-virgin olive oil.",
             "price": 10,
             "image_url": "http://localhost:8090/images/2.png",
             "id": 2,
             "name": "Margherita Pizza"
         },
         {
             "category": "entrees",
             "description": "Pacific steelhead trout with lettuce, tomato, and red onion.",
             "price": 12.75,
             "image_url": "http://localhost:8090/images/3.png",
             "id": 3,
             "name": "Grilled Steelhead Trout"
         },
         {
             "category": "appetizers",
             "description": "House-made ravioli filled with pine nuts, parmesan, ham, and mushrooms. Served over tomato sauce.",
             "price": 8,
             "image_url": "http://localhost:8090/images/4.png",
             "id": 4,
             "name": "Ham and mushroom ravioli"
         },
         {
             "category": "soups",
             "description": "Chicken simmered alongside yellow onions, carrots, celery, and bay leaves.",
             "price": 3.5,
             "image_url": "http://localhost:8090/images/5.png",
             "id": 5,
             "name": "Chicken Noodle Soup"
         },
         {
             "category": "salads",
             "description": "Garlic, red onions, tomatoes, mushrooms, and olives on top of romaine lettuce.",
             "price": 5,
             "image_url": "http://localhost:8090/images/6.png",
             "id": 6,
             "name": "Italian Salad"
         }
     ]
 }
 */
/// At the root level of the JSON is an array of dictionaries, where each dictionary represents an item on the menu.
/// `id` is a unique `Int` that distinguishes one item from another. If you add or modify a dictionary, make sure each `id` value is unique.
/// `name` is a `String` that refers to each item on the menu. The server does not require names to be unique,  but it would not make sense to repeat the same item on the menu, so keep them unique.
/// `description` is a `String` that provides further detail about the choice.
/// `price` is a `Double` that expresses the price of a menu item.
/// `category` is a `String` that provides a way to divide items, just like in a real menu.
/// `image_url` is auto created by the server to have the servers base url followed by the path "images", followed by the name of the image. The name of the image is also automatically created by the server to be the id of the item followed by the extenion .png.

//: SERVER ENDPOINTS
/// The API in this project has several URLs for implementing your app's features. Every URL begins with `http://localhost:8090` and can be combined with the following endpoints.
/// 1) /categories : a `GET` request to this endpoint will return an array of strings of the categories in the `menu.json`. The array will be available under the key "categories" in the JSON.
/// 2) /menu: a `GET` request to this endpoint will return the full array of menu items, but it can also be combines with the query parameter, category to return a subset of items. The array will be availble under the key  `items` with the JSON.
/// 3) /images: Combined with the name of the image, a `GET` request to this endpoint will return the image data associated with each menu item.
/// 4) /order: a `POST` to this endpoint with the collection of menu item `id` values will submit the order and will return a response with the estimated time before the order will be ready. The IDs you send need to be contained with JSON data under the key, menuIds. When you parse the JSOn, an estimate of time before the order is ready will be under the key "preparation_time"

