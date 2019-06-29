//
//  WebService.swift
//  Colors
//
//  Created by Matt Deuschle on 6/29/19.
//  Copyright © 2019 Matt Deuschle. All rights reserved.
//

import Foundation

typealias completion = (Bool, [Color]?) -> Void

struct WebService {
    private init() {}
    static let shared = WebService()
    func downloadColors(completion: @escaping completion) {
        let urlString = "http://www.colourlovers.com/api/colors?format=json"
        guard let url = URL(string: urlString) else {
            completion(false, nil)
            return
        }
        let task = URLSession.shared.dataTask(with: url) { data, _, error in
            DispatchQueue.main.async {
                if data != nil && error == nil {
                    if let colors = try? JSONDecoder().decode([Color].self, from: data!) {
                        completion(true, colors)
                    } else {
                        completion(false, nil)
                    }
                } else {
                    completion(false, nil)
                }
            }
        }
        task.resume()
    }
}
