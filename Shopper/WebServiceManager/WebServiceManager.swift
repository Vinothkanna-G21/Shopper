//
//  WebServiceManager.swift
//  Shopper

import Foundation
/// This will act as Web Service Manager for entire application
class WebServiceManager {
    
    /// Will Perform the GET method
    /// - Parameters:
    ///   - url: URL of requested service
    ///   - CompletionHandler: Returns the JSON Data
    static func performGetMethod(url:URL, CompletionHandler: @escaping (Data) -> Void) {

            let session = URLSession.shared

           //create dataTask using the session object to send data to the server
           let task = session.dataTask(with: url, completionHandler: { data, response, error in

               guard error == nil else {
                   return
               }

               guard let data = data else {
                   return
               }
            
            CompletionHandler(data)

           })
           task.resume()
    }
}
