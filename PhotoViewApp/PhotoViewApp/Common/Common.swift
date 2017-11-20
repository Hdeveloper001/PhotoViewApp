//
//  Common.swift
//  PhotoViewApp
//
//  Created by iOSpro on 15/11/17.
//  Copyright © 2017 iOSpro. All rights reserved.
//

import Foundation
import FirebaseDatabase

var PhotoUrlList = [String]()

let mFirebaseDB = Database.database().reference()

let albumID1 = "ABC123"
let albumName1 = "Test Album 1"
let albumPIN1 = "1234"

var currentIndex = 0

var isWakeupSelecting = false

var wakeupTime = ""
var sleepTime = ""
