import Foundation

struct SaveLocationAlert {
    
    static var shared: SaveLocationAlert = SaveLocationAlert()
    let title = "Remember current location"
    let alertMessage = "Choose color of pin: \n\n\n\n\n\n\n"
    let enterName = "Enter name"
    let cancelAction = "Cancel"
    let okAction = "Ok"
}

struct CoreDataValues {
    
    static var shared: CoreDataValues = CoreDataValues()
    let entityLocation = "Location"
    let attributeName = "name"
    let attributeLongtitude = "longtitude"
    let attributeLatitude = "latitude"
    let attributeColor = "colorItem"
    
}
