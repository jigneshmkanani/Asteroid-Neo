//
//  NeoWs.swift
//  Asteroid-Neo
//
//  Created by Admin on 06/09/2022.
//

import Foundation

protocol NeoWsServiceProtocol {
    func getFeed(req: reqFeed, completion: @escaping (_ success: Bool, _ results: Feed?, _ error: String?) -> ())
}
//https://api.nasa.gov/neo/rest/v1/feed?start_date=2022-08-01&end_date=2022-08-07&api_key=A2TX60dJPPOFgWk4qyw9JMSMsNhaIJ2VGQlAuWvz
class NeoService: NeoWsServiceProtocol {
    func getFeed(req: reqFeed, completion: @escaping (Bool, Feed?, String?) -> ()) {
        HttpRequestHelper().GET(url: "https://api.nasa.gov/neo/rest/v1/feed?", params: ["start_date": req.startDate ?? "", "end_date": req.endDate ?? "", "api_key": req.apiKey ?? ""], httpHeader: .application_json) { success, data in
            if success {
                do {
                    let model = try JSONDecoder().decode(Feed.self, from: data!)
                    completion(true, model, nil)
                } catch {
                    completion(false, nil, "Error: Trying to parse Feed to model")
                }
            } else {
                completion(false, nil, "Error: Feed GET Request failed")
            }
        }
    }
}
