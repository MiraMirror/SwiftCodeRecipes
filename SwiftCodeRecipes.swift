// swift3 play sound
import UIKit
import AVFoundation

class ViewController: UIViewController, AVAudioPlayerDelegate{
    
    var audioPlayer : AVAudioPlayer!
    let soundArray = ["note1","note2","note3","note4","note5","note6","note7"]
    
    override func viewDidLoad() {
        super.viewDidLoad()
    }
    
    @IBAction func notePressed(_ sender: UIButton) {
        
        playSound(soundFileName: soundArray[sender.tag-1])
        
    }
    
    func playSound(soundFileName : String) {
        
        let soundURL = Bundle.main.url(forResource: soundFileName, withExtension: "wav")
        
        do {
            try audioPlayer = AVAudioPlayer(contentsOf: soundURL!)
        }
        catch {
            print(error)
        }
        
        audioPlayer.play()
        
    }
    
}


// display alert message
let alert = UIAlertController(title: "Awesome", message: "You've finished!", preferredStyle: .alert)
let restartAction = UIAlertAction(title: "Restart", style: .default, handler: { (UIAlertAction) in
    self.startOver()
})
alert.addAction(restartAction)
present(alert, animated: true, completion: nil)

//center UIView frame
let squareWidth : Int = 100
let squareHeight :Int = 100

let square = UIView(frame: CGRect(x : Int(self.view.frame.width / 2) - squareWidth / 2, y : Int(self.view.frame.height / 2)-squareHeight / 2, width : squareWidth, height : squareHeight))
square.backgroundColor = UIColor.red
self.view.addSubview(square)


//install CocoaPods
sudo gem install cocoapods
pod setup --verbose

// location tracking
import CoreLocation

class WeatherViewController: UIViewController, CLLocationManagerDelegate {
    
    //Declare instance variables here
    let locationManager = CLLocationManager()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        //Set up the location manager here.
        locationManager.delegate = self
        locationManager.desiredAccuracy = kCLLocationAccuracyHundredMeters
        locationManager.requestWhenInUseAuthorization()
        // this line above will look up in plist for the request location message
        // add
        /*
         <key>NSLocationUsageDescription</key>
         <string>We need your location to obtain your current weather conditions</string>
         <key>NSLocationWhenInUseUsageDescription</key>
         <string>We need your location to obtain your current weather conditions</string>
         */
    }
}


// Alamofire get data from API
func getWeatherDate(url: String, parameters : [String : String]) {
    
    Alamofire.request(url, method : .get, parameters : parameters).responseJSON {
        response in
        if response.result.isSuccess {
            
            print("Success! Got the weather data")
            
            
        }
        else {
            print("Error: \(response.result.error)")
            self.cityLabel.text = "Connection Issues"
        }
    }
}

// pass data from one view controller to another using segue (pass city name from FirstViewController to SecondViewController)
class FirstViewController: UIViewController {
    
    @IBOutlet weak var cityName: UITextField!
    
    override func viewDidLoad() {
        super.viewDidLoad()
    }
    
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
    }
    
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        
        if segue.identifier == "goToSecondScreen" {
            let destinationViewController = segue.destination as! SecondViewController
            destinationViewController.passOverText = cityName.text
        }
        
    }
    
}

class SecondViewController: UIViewController {
    
    var passOverText : String?
    
    @IBOutlet weak var cityName: UILabel!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        cityName.text = passOverText
    }
    
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
    }
}

//switch between screens, set up button to go from FirstViewController to SecondViewController, and from SecondViewController back to FirstViewController
class FirstViewController: UIViewController {
    
    override func viewDidLoad() {
        super.viewDidLoad()
    }
    
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
    }
    
    @IBAction func showSecondScreenButtonPressed(_ sender: UIButton) {
        performSegue(withIdentifier: "goToSecondScreen", sender: self)
    }
    
}

class SecondViewController: UIViewController

override func viewDidLoad() {
    super.viewDidLoad()
}

override func didReceiveMemoryWarning() {
    super.didReceiveMemoryWarning()
}

@IBAction func backToFirstScreenButtonPressed(_ sender: UIButton) {
    
    self.dismiss(animated: true, completion: nil)
    
}
}

// using protocol to send data back to the FirstViewController
class FirstViewController: UIViewController, CanReceive {
    
    var dataPassedFromSecondScreen : String?
    
    @IBOutlet weak var firstScreenLabel: UILabel!
    
    override func viewDidLoad() {
        super.viewDidLoad()
    }
    
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
    }
    
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        
        if segue.identifier == "goToSecendScreen" {
            secondVC.delegate = self
        }
    }
    
    @IBAction func beamMeUpButtonPressed(_ sender: Any) {
        performSegue(withIdentifier: "goToSecendScreen", sender: self)
    }
    
    func dataReceived(data: String) {
        firstScreenLabel.text = data
    }
}

protocol CanReceive {
    func dataReceived(data : String)
}

class SecondViewController: UIViewController {
    
    var delegate : CanReceive?
    
    @IBOutlet weak var secondScreenTextField: UITextField!
    
    override func viewDidLoad() {
        super.viewDidLoad()
    }
    
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
    }
    
    @IBAction func sendBackButtonPressed(_ sender: Any) {
        delegate?.dataReceived(data: secondScreenTextField.text!)
        dismiss(animated: true, completion: nil)
    }
}

// use UISwitch, trigger func depending the Switch Status
import UIKit

class ViewController: UIViewController {
    
    @IBOutlet weak var mySwitch: UISwitch!
    @IBOutlet weak var label: UILabel!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        changeText()
        mySwitch.addTarget(self, action: #selector(switchToggled(_:)), for: UIControlEvents.valueChanged)
    }
    
    @IBAction func switchToggled(_ sender: UISwitch) {
        changeText()
    }
    
    func changeText() {
        if mySwitch.isOn {
            label.text = "Switch is on"
        } else {
            label.text = "Switch is off"
        }
    }
}


//Alamofire get data from API
/* with parameters */
func getWeatherDate(url: String, parameters : [String : String]) {
    
    Alamofire.request(url, method : .get, parameters : parameters).responseJSON {
        response in
        if response.result.isSuccess {
            print("Success! Got the weather data")
            
            let weatherJSON : JSON = JSON(response.result.value!)
            self.updateWeatherData(json: weatherJSON)
            
        }
        else {
            print("Error: \(String(describing: response.result.error))")
            self.cityLabel.text = "Connection Issues"
        }
    }
}

/* without parameters */
func getBitcoinData(url: String) {
    
    Alamofire.request(url, method: .get)
        .responseJSON { response in
            if response.result.isSuccess {
                
                print("Sucess! Got the Bitcoin price data")
                let bitcoinJSON : JSON = JSON(response.result.value!)
                self.updateUIBitcoinData(json: bitcoinJSON)
                
            } else {
                print("Error: \(String(describing: response.result.error))")
                self.bitcoinPriceLabel.text = "Connection Issues"
            }
    }
    
}
