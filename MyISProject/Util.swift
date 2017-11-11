//
//  Util.swift
//  MyISProject
//
//  Created by Jaruwit Sriburanasorn on 8/13/2560 BE.
//  Copyright © 2560 Kamonpan Ketlue. All rights reserved.
//

import Foundation
import UIKit
import Cloudinary

let cld = CLDCloudinary(configuration: CLDConfiguration(cloudName: "dtqcoxdoj", apiKey: "659978454396649"))

public func UIImagePNGRepresentation(_ image: UIImage?) -> Data? {
    if let image = image {
        return UIImagePNGRepresentation(image)
    } else {
        return nil
    }
}
