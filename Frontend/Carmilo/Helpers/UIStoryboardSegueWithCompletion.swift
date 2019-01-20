import UIKit

class UIStoryboardSegueWithCompletion: UIStoryboardSegue {
    
    var completion: (() -> Void)?
    
    override func perform() {
        super.perform()
        self.completion?()
    }
}
