import Foundation
import UIKit
import CoreMotion

public class SketchView: UIView {  //Mainview descende de UIView
    
    var locationHistory = [CGPoint] ()
    var shapelayerHistory = [CAShapeLayer]()
    
    var cursorView : UIView!
    
    var bezierPath = UIBezierPath()
    var gestureBeganFlag = false
    
    public var penSettings = Settings()
    
    public let motionManager = CMMotionManager()
    
    
    
    public init(frame: CGRect, settings:Settings) {
        let frame = UIScreen.main.bounds
        super.init(frame: frame)
        
        penSettings = settings
        
        cursorView = UIView(frame: CGRect(x: self.center.x, y: self.center.y, width: 6, height: 6))
        cursorView.layer.cornerRadius = 5
        
        if penSettings.accelerometerEnabled //&& motionManager.isDeviceMotionAvailable
        {
            cursorView.backgroundColor = .white
            self.addSubview(cursorView)
            
            motionManager.deviceMotionUpdateInterval = 0.01
            
            motionManager.startDeviceMotionUpdates(to: .main) {
                (data: CMDeviceMotion?, error: Error?) in
                if let attitudeData = data?.attitude {
                    
                    self.motionHandler(motionData: attitudeData)
                }
            }
            
        }
        else{
            
        }
        
    }
    
    func dist_2(a: CGPoint, b: CGPoint) -> Int {
        let xDist = a.x - b.x
        let yDist = a.y - b.y
        return Int(((xDist * xDist) + (yDist * yDist)))
    }
    
    required public init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    func motionHandler(motionData: CMAttitude)
    {
        
        cursorView.center.x += CGFloat(motionData.pitch * 5)
        if cursorView.center.x < 0.0 {cursorView.center.x = 0.0 }
        if cursorView.center.x > self.frame.width { cursorView.center.x = self.frame.width}
        
        cursorView.center.y -= CGFloat(motionData.roll * 5)
        if cursorView.center.y < 0.0 {cursorView.center.y = 0.0 }
        if cursorView.center.y > self.frame.height { cursorView.center.y = self.frame.height}
        
        let location = cursorView.center
        
        if penSettings.motionFlowControlIndex % penSettings.motionFlowControlFactor == 0 {
            lineDraw(location: location)
            
            penSettings.motionFlowControlIndex += 1
            
        }
            
        else {
            penSettings.motionFlowControlIndex += 1
        }
        
        if penSettings.motionFlowControlIndex > penSettings.motionFlowControlFactor * 100
        {
            penSettings.motionFlowControlIndex = 0
        }
        
        
    }
    
    public func clearAll() {
        
        cursorView.center = self.center
        
        for shape in shapelayerHistory {
            
            shape.removeFromSuperlayer()
            
        }
        self.shapelayerHistory.removeAll()
        self.locationHistory.removeAll()
    }
    
    
    func startDraw (location: CGPoint)
    {
        bezierPath = UIBezierPath()
        bezierPath.move(to: location)
    }
    
    func lineDraw (location: CGPoint)
    {
        
        
        bezierPath = UIBezierPath()
        
        if locationHistory.isEmpty
        {
            locationHistory.append(location)
        }
        else {
            
            
            bezierPath.move(to: locationHistory.last!)
            
            if gestureBeganFlag {
                
                startDraw(location: location)
                gestureBeganFlag = false
                
            }
            
            // The magic happens HERE 👇🏻👇🏻👇🏻👇🏻
            
            
            locationHistory.append(location)
            
            
            bezierPath.addLine(to: location)
            for p in 0..<locationHistory.count
            {
                let historyPoint = locationHistory[p]
                let randomNumber = arc4random_uniform(100)
                
                if dist_2(a: location, b: historyPoint) < penSettings.treshhold * penSettings.treshhold && randomNumber > 50
                {
                    bezierPath.addLine(to: historyPoint)
                }
                
            }
            
            
            var lineColor = penSettings.color
            
            if penSettings.rainbowEnabled {
                lineColor = penSettings.getNextColorHUE()
            }
            
            
            let shapeLayer = CAShapeLayer()
            shapeLayer.path = bezierPath.cgPath
            shapeLayer.strokeColor = lineColor.withAlphaComponent(penSettings.alpha).cgColor
            shapeLayer.fillColor = UIColor.clear.cgColor
            shapeLayer.lineWidth = penSettings.lineWidth
            self.layer.insertSublayer(shapeLayer, at: 0)
            shapelayerHistory.append(shapeLayer)
            
            if locationHistory.count > penSettings.maxOfPoints
            {
                locationHistory.removeFirst()
                let shape = shapelayerHistory.first!
                shape.removeFromSuperlayer()
                shapelayerHistory.removeFirst()
            }
            
            self.setNeedsDisplay()
        }
        
    }
    
    public override func touchesBegan(_ touches: Set<UITouch>, with event: UIEvent?) {
        if penSettings.accelerometerEnabled { return }
        gestureBeganFlag = true
        
    }
    
    public override func touchesMoved(_ touches: Set<UITouch>, with event: UIEvent?) {
        
        if penSettings.accelerometerEnabled { return }
        
        let touch: UITouch = touches.first! as UITouch
        let location: CGPoint = touch.location(in: self)
        
        lineDraw(location: location)
        
    }
    
}



