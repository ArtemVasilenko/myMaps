import UIKit
import SwiftEntryKit

struct CustomAlert {
    static var shared: CustomAlert = CustomAlert()
    
    func setupAttributes() -> EKAttributes {
        var attributes = EKAttributes.topNote
        attributes.hapticFeedbackType = .success
        attributes.displayDuration = .infinity
        attributes.shadow = .active(with: .init(color: .black, opacity: 0.3, radius: 8, offset: .zero))
        attributes.screenInteraction = .dismiss
        attributes.entryInteraction = .absorbTouches
        attributes.scroll = .enabled(swipeable: true, pullbackAnimation: .jolt)
        attributes.roundCorners = .all(radius: 8)
        attributes.entranceAnimation = .init(translate: .init(duration: 0.7, spring: .init(damping: 0.7, initialVelocity: 0)), scale: .init(from: 0.7, to: 1, duration: 0.4, spring: .init(damping: 1, initialVelocity: 0)))
        attributes.exitAnimation = .init(translate: .init(duration: 0.2))
        attributes.popBehavior = .animated(animation: .init(translate: .init(duration: 0.35)))
        attributes.positionConstraints.size = .init(width: .offset(value: 0), height: .intrinsic)
        attributes.statusBar = .dark
        attributes.screenBackground = .color(color: .init(light: UIColor(white: 100.0/250.0, alpha: 0.3), dark: UIColor(white: 50.0/255.0, alpha: 0.3)))
        
        attributes.entryBackground = .visualEffect(style: .standard)
        
        return attributes
    }
    
    func setupMessage(title: String, description: String) -> EKPopUpMessage {
        let image = UIImage(named: "CameraIcon")!
        
        let themeImage = EKPopUpMessage.ThemeImage(image: EKProperty.ImageContent(image: image, size: CGSize(width: 50, height: 50), tint: .black, contentMode: .scaleAspectFill))
        
        let titleLabel = EKProperty.LabelContent(text: title, style: .init(font:            UIFont.systemFont(ofSize: 24.0),
                                                                           color: .white,
                                                                           alignment: .left))
        
        let descriptionLabel = EKProperty.LabelContent(text: description, style: .init(font: UIFont.systemFont(ofSize: 18.0),
                                                                                       color: .white,
                                                                                       alignment: .left))
        
        let button = EKProperty.ButtonContent(label: .init(text: "Marker settings", style: .init(font: UIFont.systemFont(ofSize: 18.0), color: .white)), backgroundColor: .init(.init(cgColor: #colorLiteral(red: 0.1411764771, green: 0.3960784376, blue: 0.5647059083, alpha: 1))), highlightedBackgroundColor: .clear)
        
        let message = EKPopUpMessage(themeImage: themeImage, title: titleLabel, description: descriptionLabel, button: button) {
            SwiftEntryKit.dismiss()
        }
        
        
        return message
    }
}
