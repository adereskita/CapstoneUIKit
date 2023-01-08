//
//  APICall.swift
//  Capstone
//
//  Created by Ade Reskita on 17/12/22.
//

import Foundation
import Alamofire

struct API {
    static let baseUrl = "https://api.rawg.io/api/"
    static func keyParams(with params: String = "") -> Parameters {
        var parameter: Parameters = [
            "key": "10cd9f11a8884b58ab2048e197b3724b",
            "search": params
        ]
        parameter.filter({ ($0.value as! String).isEmpty }).forEach({ parameter[$0.key] = nil})
        return parameter
    }
}

protocol Endpoint {
    var url: String { get }
}

enum Endpoints {
    
    enum Gets: Endpoint {
        case games
        case genres
        case gameDetails(id: String)
        
        public var url: String {
            switch self {
            case .games: return "\(API.baseUrl)games"
            case .genres: return "\(API.baseUrl)genres"
            case .gameDetails(let id): return "\(API.baseUrl)games/\(id)"
            }
        }
    }
}
