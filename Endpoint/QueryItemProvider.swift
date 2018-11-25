//
//  QueryItemProvider.swift
//  MusicMasterFront
//
//  Created by Jay Doshi on 11/23/18.
//  Copyright © 2018 Jay Doshi. All rights reserved.
//

import Foundation

protocol QueryItemProvider {
    var queryItem: URLQueryItem { get }
}
