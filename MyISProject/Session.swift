//
//  Session.swift
//  MyISProject
//
//  Created by Jaruwit Sriburanasorn on 8/20/2560 BE.
//  Copyright © 2560 Kamonpan Ketlue. All rights reserved.
//

import Foundation

class Session {
    private init() {}
    static let shared = Session()
    var user: UserModel!
}
