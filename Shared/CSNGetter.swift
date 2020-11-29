//
//  CSNGetter.swift
//  Vaporwave Music Player
//
//  Created by vaanh on 29/11/2020.
//

import Foundation
import Alamofire

class CSNGetter{
    static func getSongUrl(query: String) {
        var songid : String
        let parameters: Parameters = [
             //  "q": query
            "s" : query
               ]
       // let z = "https://chiasenhac.vn/api/search?row=1"
        let z = "http://search.nhacgoc.com/api/search.php?code=csn22052018&row=1"
        AF.request(z,
                   method: .get,
                   parameters: parameters
        ).responseJSON { response in
            if let json = response.value as? [String: Any] {
                print("JSON: \(json)") // serialized json response
                
            }
        }
    
    
    }
    
    
}
