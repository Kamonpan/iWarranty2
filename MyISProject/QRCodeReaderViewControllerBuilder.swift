//
//  QRCodeReaderViewControllerBuilder.swift
//  MyISProject
//
//  Created by Kamonpan Ketlue on 7/18/2560 BE.
//  Copyright © 2560 Kamonpan Ketlue. All rights reserved.
//

import Foundation

/**
 The QRCodeViewControllerBuilder aims to create a simple configuration object for
 the QRCode view controller.
 */
public final class QRCodeReaderViewControllerBuilder {
    // MARK: - Configuring the QRCodeViewController Objects
    
    /**
     The builder block.
     The block gives a reference of builder you can configure.
     */
    public typealias QRCodeReaderViewControllerBuilderBlock = (QRCodeReaderViewControllerBuilder) -> Void
    
    /**
     The title to use for the cancel button.
     */
    public var cancelButtonTitle = "ข้ามการ scan"
    
    /**
     The code reader object used to scan the bar code.
     */
    public var reader = QRCodeReader()
    
    /**
     The reader container view used to display the video capture and the UI components.
     */
    public var readerView = QRCodeReaderContainer(displayable: QRCodeReaderView())
    
    /**
     Flag to know whether the view controller start scanning the codes when the view will appear.
     */
    public var startScanningAtLoad = true
    
    /**
     Flag to display the cancel button.
     */
    public var showCancelButton = true
    
    /**
     Flag to display the switch camera button.
     */
    public var showSwitchCameraButton = true
    
    /**
     Flag to display the toggle torch button. If the value is true and there is no torch the button will not be displayed.
     */
    public var showTorchButton = false
    
    /**
     Flag to display the guide view.
     */
    public var showOverlayView = true
    
    /**
     Flag to display the guide view.
     */
    public var handleOrientationChange = true
    
    
    // MARK: - Initializing a Flap View
    
    /**
     Initialize a QRCodeViewController builder with default values.
     */
    public init() {}
    
    /**
     Initialize a QRCodeReaderViewController builder with default values.
     
     - parameter buildBlock: A QRCodeReaderViewController builder block to configure itself.
     */
    public init(buildBlock: QRCodeReaderViewControllerBuilderBlock) {
        buildBlock(self)
    }
}

