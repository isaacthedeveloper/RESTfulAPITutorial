//
//  NetworkingController.swift
//  RESTfulAPITutorial
//
//  Created by Isaac Ballas on 2019-12-20.
//  Copyright © 2019 Isaac Ballas. All rights reserved.
//

import Foundation

class NetworkController {
    static let shared = NetworkController()
    
    let baseURL = URL(string: "http://localhost:8090/")!
/// Think about the API requests the app is going to make. a GET for categories, a GET for items within a category and a POST containing the suers order when it is time to communicate back to the server.
    
    /// For the /categories endpoint there are no query parameters or additional data to send and that the response JSON will contain an array of string. So the method should have one parameter: a completion closure that uses an array of strings.
    func fetchCategories(completion: @escaping ([String]?) -> Void) {
        let categoryURL = baseURL.appendingPathComponent("categories")
        let task = URLSession.shared.dataTask(with: categoryURL) { (data, response, error) in
            if let data = data, let jsonDictionary = try? JSONSerialization.jsonObject(with: data) as? [String: Any], let categories = jsonDictionary["categories"] as? [String] {
                completion(categories)
            } else {
                completion(nil)
            }
        }
        task.resume()
    }
    
    /// The request to /menu includes a query parameter: The category string. The JSON that is returned contains an array of dictionaries, and you will want to deserialize each dictionary into a `MenuItem` object. So the method that will perform the reques to /menu should have two parameters: The category string, and a completion closure that takes in an array of `MenuItem` object.
    func fetchMenuItems(forCategory categoryName: String, completion: @escaping ([MenuItem]?) -> Void) {
        /// You need to add the query parameter. You can use `URLComponents` to append a collection of `URLQueryItem` objects. In this case, there is only one query parameter in the collection, and the value should be equal to the supplied argument.
        /// NOTE: We use force unwrapping here since we know the server exists, however, in the app for AthleteRMS it is server side data so you should safely unwrap it instead of forcing it.
        let initialMenuURL = baseURL.appendingPathComponent("menu")
        var components = URLComponents(url: initialMenuURL, resolvingAgainstBaseURL: true)!
        components.queryItems = [URLQueryItem(name: "category", value: categoryName)]
        let menuURL = components.url!
        let task = URLSession.shared.dataTask(with: menuURL) { (data, response, error) in
            /// The data retrieved from this endpoint will be converted into an array of MenuItem objects. You will first need to create a JSONDecoded for decoding the JSON data returned by the API. Again, data is an optional value. So you will need to unwrap it. Since the top level of the data is an items key with an array as its value, you use the JSONDecoder to decode the data into a single MenuItems object. If the data is succesfully decoded, you call completion and pass in the items property on hte MenuItems object. If there is a fialure you call completion too.
            let jsonDecoder = JSONDecoder()
            if let data = data, let menuItems = try? jsonDecoder.decode(MenuItems.self, from: data) {
                completion(menuItems.items)
            } else {
                completion(nil)
            }
        }
        task.resume()
    }
    
    /// The POST to /order will need to include the collection of menu item IDs and the response will include an integer specifying the number of minutes the order will take to prep. The method that will perform this network call should have two parameters: an array of integers to hold the IDs and a completion closure that takes in the order prep time.
    func submitOrder(forMenuIDs menuIds: [Int], completion: @escaping (Int?) -> Void) {
        let orderURL = baseURL.appendingPathComponent("order")
        /// POST request is different. First you will need to modify the requests default type from a GET to a POST. Then, you tell the server what kind of data you will be sending (JSON).
        var request = URLRequest(url: orderURL)
        request.httpMethod = "POST"
        request.setValue("application/json", forHTTPHeaderField: "Content-Type")
        /// Next store the array of menu IDs in JSON under the key `menuIds` To do this, create a dictionary of type `[String: [Int]]` a type that can be converted to or from JSON by an instance of `JSONEncoder`.
        let data: [String: [Int]] = ["menuIds": menuIds]
        let jsonEncoder = JSONEncoder()
        let jsonData = try? jsonEncoder.encode(data)
        /// Unlike a GET which appends query parameters to the URL, the data for a POST must be stored within the body of the request. ONce that is in place, you can create the `URLSessionDataTask`
        request.httpBody = jsonData
        let task = URLSession.shared.dataTask(with: request) { (data, response, error) in
            /// Return JSON data that can be decoded into `PreparationTime` model.
            let jsonDecoder = JSONDecoder()
            if let data = data, let preparationTime = try? jsonDecoder.decode(PreparationTime.self, from: data) {
                completion(preparationTime.prepTime)
            } else {
                completion(nil)
            }
        }
        task.resume()
    }
    
}
