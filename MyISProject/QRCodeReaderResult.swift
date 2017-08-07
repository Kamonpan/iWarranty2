//
//  QRCodeReaderResult.swift
//  QR Test
//
//  Created by Kamonpan Ketlue on 7/16/2560 BE.
//  Copyright © 2560 Kamonpan Ketlue. All rights reserved.
//

import Foundation
//น่าจะใช้ในการตัด string
/**
 The result of the scan with its content value and the corresponding metadata type.
 */
public struct QRCodeReaderResult {
    
    
    /**
     The error corrected data decoded into a human-readable string.
     */
    public let value: String
    
    /**
     The type of the metadata.
     */
    public let metadataType: String
}
