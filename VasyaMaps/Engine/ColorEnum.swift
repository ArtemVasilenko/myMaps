import Foundation
import UIKit

struct Color {
    var color: PinColor?
    static var shared = Color()
}

enum PinColor : String, CaseIterable {
    case Red = "red"
    case Violet = "purple"
    case Green = "green"
    case Blue = "blue"
    case Black = "black"
    case Yellow = "yellow"
    case Gray = "gray"
    
    func getColor() -> UIColor {
        switch self {
        case .Violet:
            return UIColor.purple
        case .Red:
            return UIColor.red
        case .Green:
            return UIColor.green
        case .Blue:
            return UIColor.blue
        case .Black:
            return UIColor.black
        case .Yellow:
            return UIColor.yellow
        case .Gray:
            return UIColor.systemGray
        }
    }
    
    var descriptionImage: String {
        switch self {
        case .Red:
            return "red"
        case .Violet:
            return "purple"
        case .Green:
            return "green"
        case .Blue:
            return "blue"
        case .Black:
            return "black"
        case .Yellow:
            return "yellow"
        case .Gray:
            return "gray"
        }
    }
}
