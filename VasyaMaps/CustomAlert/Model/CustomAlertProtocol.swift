import Foundation
import SwiftEntryKit

protocol CustomALertProtocol {
    func showCustomAlert(markerTitle: String, country: String, city: String, address: String)
}


extension CustomALertProtocol {
    
    func showCustomAlert(markerTitle: String, country: String, city: String, address: String) {
        
        SwiftEntryKit.display(entry: AlertPopUpView(with: CustomAlert.shared.setupMessage(title: markerTitle, description: "\(country), \(city), \(address)")), using: CustomAlert.shared.setupAttributes())
    }

}
