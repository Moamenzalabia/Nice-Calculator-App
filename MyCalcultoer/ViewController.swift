//  MyCalcultoer
//  Created by mohamed mahmoud zead on 2/24/18.
//  Copyright © 2018 Mac. All rights reserved.

import UIKit
import AVFoundation

class ViewController: UIViewController {

    @IBOutlet var output: UILabel!
    var btnSound : AVAudioPlayer!
    var runningNumber = ""
    var leftValStr = ""
    var rightValStr = ""
    var result = ""
    
    enum Operation : String{
        case Divide = "/"
        case MultiPly = "*"
        case SubTract = "-"
        case Add = "+"
        case Empty = "Empty"
      
    }
    
    override var preferredStatusBarStyle: UIStatusBarStyle {
        return UIStatusBarStyle.lightContent
    }
    
    var currentOperation = Operation.Empty
    override func viewDidLoad() {
        super.viewDidLoad()
        
        let path = Bundle.main.path(forResource: "btn", ofType: "wav")
        let soundURL = URL(fileURLWithPath: path!)
        
        do{
        try btnSound = AVAudioPlayer(contentsOf: soundURL)
            btnSound.prepareToPlay()
        } catch let err as NSError {
            print(err.debugDescription)
        
        }
        
    }
    @IBAction func numberPressed(sender: UIButton){
      playSound()
        runningNumber += "\(sender.tag)"
        output.text = runningNumber
    }
    
    @IBAction func onDividePressed(sender: AnyObject){
        processOPeration(operation: .Divide)
        
    }
    @IBAction func onMultiPlyPressed(sender: AnyObject){
      processOPeration(operation: .MultiPly)
        
    }
    @IBAction func onSubTractPressed(sender: AnyObject){
        processOPeration(operation: .SubTract)
        
    }
    @IBAction func onADDPressed(sender: AnyObject){
        processOPeration(operation: .Add)
        
    }
    @IBAction func onEqualPressed(sender: AnyObject){
        processOPeration(operation: currentOperation)
        
    }
    
    func playSound(){
        if btnSound.isPlaying {
        btnSound.stop()
        }
        btnSound.play()
        
    }
    func processOPeration(operation : Operation){
        playSound()
        if currentOperation != Operation.Empty {
            
            // A user Selected an operation , but than selected another operator without first entering a number
            if runningNumber != "" {
              rightValStr = runningNumber
              runningNumber = ""
                
                if currentOperation == Operation.MultiPly{
                 result = "\(Double(leftValStr)! * Double(rightValStr)!)"
                } else if currentOperation == Operation.Divide{
                      result = "\(Double(leftValStr)! / Double(rightValStr)!)"
                }else if currentOperation == Operation.SubTract{
                  result = "\(Double(leftValStr)! - Double(rightValStr)!)"
                }
                else if currentOperation == Operation.Add{
                  result = "\(Double(leftValStr)! + Double(rightValStr)!)"
                }
                leftValStr = result
                output.text = result
            }
             currentOperation = operation
        }else{
           // This first time an operator has been pressed
            leftValStr = runningNumber
            runningNumber = ""
            currentOperation = operation
        }
    }
}
