//#-hidden-code
import UIKit
import CoreGraphics
//#-end-hidden-code
/*:
 ## Try with motion!!!
 
 ---
 
 Now, we can use [CoreMotion](https://developer.apple.com/reference/coremotion) framework to move the cursor and make lines. Tilt your iPad to create your shapes now.
 
 ---
 
 - Note:
For a better experience, turn on rotation lock on your iPad and keeping in landscape mode with home buttom on right side
 
 
 - Experiment:
 Change parameters below and see the effects
 
 */
//#-hidden-code

import UIKit
import PlaygroundSupport


let settings = Settings()

var background = UIColor.black
var lineWidth : CGFloat  = 0.8
var lineColor = UIColor.green
var enableRainbowMode = true
var treshhold = 60

settings.accelerometerEnabled = true

let sketch = SketchView(frame: CGRect(x: 0, y: 0, width: 400 , height: 400),settings: settings)

let btnClear = UIButton()
//BTN Clear Setup**********
btnClear.addTarget(sketch, action: #selector(sketch.clearAll), for: .touchUpInside)

btnClear.backgroundColor = settings.buttonColor
btnClear.frame.size = CGSize(width: 50, height: 25)
btnClear.frame.origin = CGPoint(x: 10, y: 50)
btnClear.setTitle("clear", for: .normal)
btnClear.setTitleColor(UIColor.black, for: .normal)
btnClear.layer.cornerRadius = 6

//**************************************
//#-end-hidden-code

enableRainbowMode = /*#-editable-code*/true/*#-end-editable-code*/
background = /*#-editable-code*/#colorLiteral(red: 0, green: 0, blue: 0, alpha: 1)/*#-end-editable-code*/
lineColor = /*#-editable-code*/#colorLiteral(red: 0.4666666687, green: 0.7647058964, blue: 0.2666666806, alpha: 1)/*#-end-editable-code*/
lineWidth = /*#-editable-code*/0.7/*#-end-editable-code*/
treshhold =  /*#-editable-code*/60/*#-end-editable-code*/
//#-hidden-code


settings.color = lineColor
settings.lineWidth = lineWidth
settings.rainbowEnabled = enableRainbowMode
settings.treshhold = treshhold
settings.maxOfPoints = 800

settings.alpha = 0.5

sketch.backgroundColor = background

sketch.addSubview(btnClear)

sketch.penSettings = settings
PlaygroundPage.current.liveView = sketch

PlaygroundPage.current.needsIndefiniteExecution = true
//#-end-hidden-code
//: [Next](@next)