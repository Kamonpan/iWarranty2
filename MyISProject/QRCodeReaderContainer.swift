////
////  QRCodeReaderContainer.swift
////  MyISProject
////
////  Created by Kamonpan Ketlue on 7/18/2560 BE.
////  Copyright © 2560 Kamonpan Ketlue. All rights reserved.
////
//
//import UIKit
//
///// The `QRCodeReaderDisplayable` procotol that each view embeded a `QRCodeReaderContainer` must conforms to. It defines the required UI component needed and the mandatory methods.
//public protocol QRCodeReaderDisplayable {
//    /// The view that display video as it is being captured by the camera.
//    var cameraView: UIView { get }
//    
//    /// A skipbutton.
//    var skipButton: UIButton? { get }
//    
//    /// A toggle torch button.
//    var toggleTorchButton: UIButton? { get }
//    
//    /// A guide view upon the camera view
//    var overlayView: UIView? { get }
//    
//    /**
//     Method called by the container to allows you to layout your view properly using the given flags.
//     
//     - Parameter showCancelButton: Flag to know whether you should display the cancel button.
//     - Parameter showSwitchCameraButton: Flag to know whether you should display the switch camera button.
//     - Parameter showTorchButton: Flag to know whether you should display the toggle torch button.
//     */
//    func setupComponents(showSkipButton: Bool,showTorchButton: Bool, showOverlayView: Bool)
//}
//
///// The `QRCodeReaderContainer` structure embed the view displayed by the controller. The embeded view must be conform to the `QRCodeReaderDisplayable` protocol.
//public struct QRCodeReaderContainer {
//    let view: UIView
//    let displayable: QRCodeReaderDisplayable
//    
//    /**
//     Creates a QRCode container object that embeds a given displayable view.
//     
//     - Parameter displayable: An UIView conforms to the `QRCodeReaderDisplayable` protocol.
//     */
//    public init<T: QRCodeReaderDisplayable>(displayable: T) where T: UIView {
//        self.view        = displayable
//        self.displayable = displayable
//    }
//    
//    // MARK: - Convenience Methods
//    
//    func setupComponents(showSkipButton: Bool, showTorchButton: Bool, showOverlayView: Bool) {
//        displayable.setupComponents(showSkipButton: showSkipButton, showTorchButton: showTorchButton, showOverlayView: showOverlayView)
//    }
//}
//
//  QRCodeReaderViewContainer.swift
//  QR Test
//
//  Created by Kamonpan Ketlue on 7/16/2560 BE.
//  Copyright © 2560 Kamonpan Ketlue. All rights reserved.
//

import UIKit

/// The `QRCodeReaderDisplayable` procotol that each view embeded a `QRCodeReaderContainer` must conforms to. It defines the required UI component needed and the mandatory methods.
public protocol QRCodeReaderDisplayable {
    /// The view that display video as it is being captured by the camera.
    var cameraView: UIView { get }
    
    /// A cancel button.
    var cancelButton: UIButton? { get }
    
    /// A switch camera button.
    var switchCameraButton: UIButton? { get }
    
    /// A toggle torch button.
    var toggleTorchButton: UIButton? { get }
    
    /// A guide view upon the camera view
    var overlayView: UIView? { get }
    
    /**
     Method called by the container to allows you to layout your view properly using the given flags.
     
     - Parameter showCancelButton: Flag to know whether you should display the cancel button.
     - Parameter showSwitchCameraButton: Flag to know whether you should display the switch camera button.
     - Parameter showTorchButton: Flag to know whether you should display the toggle torch button.
     */
    func setupComponents(showCancelButton: Bool, showSwitchCameraButton: Bool, showTorchButton: Bool, showOverlayView: Bool)
}

/// The `QRCodeReaderContainer` structure embed the view displayed by the controller. The embeded view must be conform to the `QRCodeReaderDisplayable` protocol.
public struct QRCodeReaderContainer {
    let view: UIView
    let displayable: QRCodeReaderDisplayable
    
    /**
     Creates a QRCode container object that embeds a given displayable view.
     
     - Parameter displayable: An UIView conforms to the `QRCodeReaderDisplayable` protocol.
     */
    public init<T: QRCodeReaderDisplayable>(displayable: T) where T: UIView {
        self.view        = displayable
        self.displayable = displayable
    }
    
    // MARK: - Convenience Methods
    
    func setupComponents(showCancelButton: Bool, showSwitchCameraButton: Bool, showTorchButton: Bool, showOverlayView: Bool) {
        displayable.setupComponents(showCancelButton: showCancelButton, showSwitchCameraButton: showSwitchCameraButton, showTorchButton: showTorchButton, showOverlayView: showOverlayView)
    }
}
