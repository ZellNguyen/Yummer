//
//  NetworkManager.swift
//  Yummer
//
//  Created by Hoa Nguyen on 2017-06-25.
//  Copyright © 2017 Hoa Nguyen. All rights reserved.
//

import Foundation

class NetworkManager {

    static var status: String = "" {
        didSet {
            print(status)
            print("\(Login.TAG).DONE")
            //if status == "\(Login.TAG).DONE" {
            //    Decision.main.fetch()
            //}
            if status == "\(Login.TAG).DONE" {
                RestaurantViewModel.shared.load()
            }
        }
    }
}

protocol NetworkDelegate {
    func onRetrieved(resultAtIndex index: Int);
}
