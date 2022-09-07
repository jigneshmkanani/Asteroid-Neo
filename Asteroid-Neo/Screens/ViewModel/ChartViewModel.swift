//
//  ChartViewModel.swift
//  Asteroid-Neo
//
//  Created by Admin on 06/09/2022.
//

import Foundation

class ChartViewModel: NSObject {
    private var feedService: NeoWsServiceProtocol
    var updateStatatistics: (() -> Void)?
    var reloadTableView: (() -> Void)?
    
    var FastestAsteroid : Double = 0
    var ClosestAsteroid : Double = 0
    var AverageSizeAstroid : Double = 0
    var isClosest = false
    var isFastest = false
    var iCountAstroid = 0
    var TotalAstroid = [chartValue]() {
        didSet {
            self.updateStatatistics?()
        }
    }
    
    init(feedService: NeoWsServiceProtocol = NeoService()) {
        self.feedService = feedService
    }
    
    func getFeed(startDate: String, endDate: String) {
        AverageSizeAstroid = 0
        iCountAstroid = 0
        if (!startDate.isEmpty && !endDate.isEmpty) {
            if (true) {
                let req = reqFeed.init(startDate: startDate, endDate: endDate, apiKey: "A2TX60dJPPOFgWk4qyw9JMSMsNhaIJ2VGQlAuWvz")
                feedService.getFeed(req: req) { success, model, error in
                    if success, let feed = model {
                        let sorted1 = feed.nearEarthObjects?.sorted { (lhs, rhs) -> Bool in
                            return lhs.key < rhs.key
                        }
                        let p : Int = sorted1?.count ?? 0
                        var TotalAstroid1 = [chartValue]()
                        for i in 0...p-1 {
                            debugPrint(Double(sorted1?[i].value.count ?? 0))
                            TotalAstroid1.append(chartValue.init(value: Double(sorted1?[i].value.count ?? 0)))
                            self.getFastestAsteroid(daysData: (sorted1?[i].value)!)
                            self.getClosestAsteroid(daysData: (sorted1?[i].value)!)
                            self.getAverageAsteroid(daysData: (sorted1?[i].value)!)
                            self.AverageSizeAstroid = self.AverageSizeAstroid/Double(self.iCountAstroid)
                        }
                        self.TotalAstroid = TotalAstroid1
                    } else {
                        print(error!)
                    }
                }
            } else {
                DispatchQueue.main.async { [self] in
                    AverageSizeAstroid = 0
                    iCountAstroid = 0
                    let feed = loadJson(filename: "feedAPI")
                    if let feed = feed {
                        let sorted1 = feed.nearEarthObjects?.sorted { (lhs, rhs) -> Bool in
                            return lhs.key < rhs.key
                        }

                        let p : Int = sorted1?.count ?? 0
                        var TotalAstroid1 = [chartValue]()
                        for i in 0...p-1 {
                            debugPrint(Double(sorted1?[i].value.count ?? 0))
                            TotalAstroid1.append(chartValue.init(value: Double(sorted1?[i].value.count ?? 0)))
                            getFastestAsteroid(daysData: (sorted1?[i].value)!)
                            getClosestAsteroid(daysData: (sorted1?[i].value)!)
                            getAverageAsteroid(daysData: (sorted1?[i].value)!)
                            AverageSizeAstroid = AverageSizeAstroid/Double(iCountAstroid)
                        }
                        
                        self.TotalAstroid = TotalAstroid1
                    }
                }
            }
        } else {
            debugPrint("Select start and end date first")
        }
    }
    
    func getFastestAsteroid(daysData: [FeedNearEarthObject]) {
        for data in daysData {
            let number = Double(data.closeApproachData?[0].relativeVelocity?.kilometersPerHour ?? "0") ?? 0
            if number < FastestAsteroid {
                FastestAsteroid = number
            }
            if !isFastest {
                FastestAsteroid = number
                isFastest = true
            }
        }
    }
    
    func getClosestAsteroid(daysData: [FeedNearEarthObject]) {
        for data in daysData {
            let number = Double(data.closeApproachData?[0].missDistance?.kilometers ?? "0") ?? 0
            if number < ClosestAsteroid {
                ClosestAsteroid = number
            }
            if !isClosest {
                ClosestAsteroid = number
                isClosest = true
            }
        }
    }
    
    func getAverageAsteroid(daysData: [FeedNearEarthObject]) {
        for data in daysData {
            let number = (Double(data.estimatedDiameter?.kilometers?.estimatedDiameterMin ?? 0) + Double(data.estimatedDiameter?.kilometers?.estimatedDiameterMax ?? 0))/2
            iCountAstroid += 1
            AverageSizeAstroid += number
        }
    }
    
    func loadJson(filename fileName: String) -> Feed? {
        if let url = Bundle.main.url(forResource: fileName, withExtension: "json") {
            do {
                let data = try Data(contentsOf: url)
                let decoder = JSONDecoder()
                let jsonData = try decoder.decode(Feed.self, from: data)
                return jsonData.self
            } catch {
                print("error:\(error)")
            }
        }
        return nil
    }
}
