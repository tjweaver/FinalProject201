//
//  ItunesError.swift
//  MusicMasterFront
//
//  Created by Jay Doshi on 11/23/18.
//  Copyright © 2018 Jay Doshi. All rights reserved.
//

import Foundation

enum ItunesError: Error {
    case requestFailed
    case responseUnsuccessful
    case invalidData
    case jsonConversionFailure
    case jsonParsingFailure(message: String)
}
