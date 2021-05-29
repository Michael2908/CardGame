

import UIKit

class LaunchViewController: UIViewController {

    
    @IBOutlet weak var playBtn: UIButton!
    @IBOutlet weak var normalBtn: UIButton!
    @IBOutlet weak var easyBtn: UIButton!
    @IBOutlet weak var top10: UIButton!
    @IBOutlet weak var hardBtn: UIButton!
    
    var difficulty : GameLevel = GameLevel.normal
  
    
    override func viewDidLoad() {
        super.viewDidLoad()
    }
    
    override var shouldAutorotate: Bool{
        return false
    }
    override open var supportedInterfaceOrientations: UIInterfaceOrientationMask{
        return .portrait
    }
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        if let vc = segue.destination as? ViewController{
            vc.difficulty = difficulty
        }
    }
    
    @IBAction func topTen(_ sender: Any){
        
    }
    
    @IBAction func play(_ sender: Any){
        
    }

    @IBAction func easy(_ sender: Any){
        difficulty = GameLevel.easy
        easyBtn.backgroundColor = UIColor.yellow
    }
        
    @IBAction func normal(_ sender: Any){
        difficulty = GameLevel.normal
        normalBtn.backgroundColor = UIColor.yellow
    }
        
    @IBAction func hard(_ sender: Any){
        difficulty = GameLevel.hard
        hardBtn.backgroundColor = UIColor.yellow
    }

}
