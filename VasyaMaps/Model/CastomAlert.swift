import UIKit
import SwiftEntryKit

struct CustomAlert {
    static var shared: CustomAlert = CustomAlert()
    
    func setupAttributes() -> EKAttributes {
        var attributes = EKAttributes.bottomFloat
        attributes.displayDuration = .infinity
        attributes.screenBackground = .color(color: .init(light: UIColor(white: 100.0/250.0, alpha: 0.5), dark: UIColor(white: 50.0/255.0, alpha: 0.3)))
        attributes.shadow = .active(with: .init(
                                        color: .black,
                                        opacity: 0.3,
                                        radius: 8.0))
        attributes.screenInteraction = .dismiss
        attributes.entryInteraction = .absorbTouches
        attributes.scroll = .enabled(swipeable: true, pullbackAnimation: .jolt)
        attributes.entranceAnimation = .init(translate: .init(duration: 0.7,
                                                              spring: .init(damping: 1, initialVelocity: 0)),
                                             scale: .init(from: 1.05,
                                                          to: 1,
                                                          duration: 0.4,
                                                          spring: .init(damping: 1, initialVelocity: 0)))
        attributes.exitAnimation = .init(translate: .init(duration: 0.2))
        attributes.popBehavior = .animated(animation: .init(translate: .init(duration: 0.2)))
        attributes.positionConstraints.verticalOffset = 10
        attributes.statusBar = .dark
        
        return attributes
    }
    
    func setupMessgage(title: String, description: String) -> EKPopUpMessage {
        let titleLabel = EKProperty.LabelContent(text: title,
                                            style: .init(font: UIFont.systemFont(ofSize: 24),
                                                                color: .black,
                                                                alignment: .center))
        let descriptionLabel = EKProperty.LabelContent(text: description,
                                                       style: .init(font: UIFont.systemFont(ofSize: 18.0), color: .black, alignment: .center))
        
        let button = EKProperty.ButtonContent(label: .init(text: "Ok",
                                                           style: .init(font: UIFont.systemFont(ofSize: 18), color: .black)), backgroundColor: .init(.purple), highlightedBackgroundColor: .clear)
        
        let messgae = EKPopUpMessage(title: titleLabel, description: descriptionLabel, button: button) {
            SwiftEntryKit.dismiss()
        }
        
        
        return messgae
    }
}
