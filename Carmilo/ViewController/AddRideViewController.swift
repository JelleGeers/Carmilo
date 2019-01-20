import UIKit
class AddRideViewController: UIViewController {
    

    @IBOutlet weak var textfieldDeparture: UITextField!
    
    @IBOutlet weak var textfieldDate: UITextField!
    
    
    @IBOutlet weak var textfieldStreet: UITextField!
    
    @IBOutlet weak var textfieldHousenr: UITextField!
    
    @IBOutlet weak var textfieldZipcode: UITextField!
    
    @IBOutlet weak var textfieldMaxPassengers: UITextField!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        //if self.textfieldDate.toString().isEmpty || self.textfieldStreet.isEmpty{
            
        
        // Do any additional setup after loading the view.
    }

    @IBAction func addRide(_ sender: UIButton) {
        let passenger = [Passenger]()
        guard let url = URL(string:"http://localhost:3000/API/rides/5c41f4d7fc176e0750077b8e/rides") else { return }
        var request = URLRequest(url :url)
        request.httpMethod = "POST"
        request.addValue("application/json", forHTTPHeaderField: "Content-Type")
        
        let address = Address(street:self.textfieldStreet.text!, houseNr:self.textfieldHousenr.text!, zipcode:self.textfieldZipcode.text!)
        let rideInfo = RideInfo(departure: self.textfieldDeparture.text!, date: self.textfieldDate.text!,passengers:passenger,address: address, maxPassengers:self.textfieldMaxPassengers.text!)
        do{
            let jsonBody = try JSONEncoder().encode(rideInfo)
            request.httpBody = jsonBody
        } catch {}
        
        let session = URLSession.shared
        let task = session.dataTask(with:request) { (data, _, _) in
            guard let data = data else { return }
            do {
                let sentPost = try JSONDecoder().decode(Ride.self, from: data)
                print(sentPost)
            }catch {}
        }
        task.resume()
        }
}
