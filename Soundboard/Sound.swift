//
//  Sound.swift
//  Soundboard
//
//  Created by VIJAY VENKATESH on 6/27/15.
//  Copyright (c) 2015 VIJAY VENKATESH. All rights reserved.
//

import Foundation
import CoreData

class Sound: NSManagedObject {

    @NSManaged var name: String
    @NSManaged var url: String

}
