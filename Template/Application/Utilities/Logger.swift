//
//  Logger.swift
//  Application
//
//  Created by Sang Nguyen on 3/16/19.
//  Copyright © 2019 Sang Nguyen. All rights reserved.
//

import UIKit
import SwiftyBeaver

let logger = SwiftyBeaver.self

func SetupLogger() {
    let console = ConsoleDestination()  // log to Xcode Console
    let file = FileDestination()  // log to default swiftybeaver.log file
    
    // use custom format and set console output to short time, log level & message
    console.format = "$DHH:mm:ss.SSS$d $C$L$c $N.$F[$l] $M"
    
    // add the destinations to SwiftyBeaver
    logger.addDestination(console)
    logger.addDestination(file)
}
