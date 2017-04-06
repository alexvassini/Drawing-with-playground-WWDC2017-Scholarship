import Foundation
import UIKit

public class Settings {
    
    //Line Settings
    public var color = UIColor.orange
    public var lineWidth : CGFloat = 0.8
    public var alpha : CGFloat = 0.6
    public var rainbowEnabled = false
    public var treshhold = 40
    public var maxOfPoints = 800
    //***************************
    
    //Buttons Settings
    
    public let buttonColor = UIColor.white.withAlphaComponent(0.7)
    public let buttonLineWidth = 1.0
    public let buttonBorderColor = UIColor.black
    public let buttonCornerRatius = 1.0
    public let buttonSize = CGSize(width: 50, height: 50)

    //****************************
    
    //Accelerometer mode
    public var accelerometerEnabled = false
    //*****************************
    
    //Line flow control
    public let motionFlowControlFactor = 3
    public var motionFlowControlIndex = 0
    
    
    
    //********************
       
    // For Rainbow mode Settings
    var colorHue : CGFloat = 0.01
    var colorSaturation : CGFloat = 0.5
    var colorBrightness : CGFloat = 0.8
    //************
    
    
    
    public init()
    {
        
        
    }
    
    public func getNextColorHUE() -> UIColor {
        colorHue += 0.005
        if (colorHue > 1) {
            colorHue = 0
        }
        return UIColor(hue: colorHue, saturation: colorSaturation, brightness: colorBrightness, alpha: 1.0)
        
    }
    
    
    
    
}


