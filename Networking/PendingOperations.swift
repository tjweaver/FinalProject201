//
//  PendingOperations.swift
//  MusicMasterFront
//
//  Created by Jay Doshi on 11/24/18.
//  Copyright © 2018 Jay Doshi. All rights reserved.
//

import Foundation

class PendingOperations {
    var downloadsInProgress = [IndexPath: Operation]()
    
    let downloadQueue = OperationQueue()
}
