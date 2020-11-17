import Foundation

struct SaveLocationAlert {
    
    static var shared: SaveLocationAlert = SaveLocationAlert()
    let title = "Remember current location"
    let alertMessage = "Choose color of pin: \n\n\n\n\n\n\n"
    let enterName = "Enter name"
    let cancelAction = "Cancel"
    let okAction = "Ok"
}

enum CoreDataValues: String {
    case entityLocation = "Location"
    case attributeName = "name"
    case attributeLongtitude = "longtitude"
    case attributeLatitude = "latitude"
    case attributeColor = "colorItem"
}
