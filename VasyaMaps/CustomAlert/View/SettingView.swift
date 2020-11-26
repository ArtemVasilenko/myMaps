import UIKit
import CoreData
import GoogleMaps

class SettingsView: UIView {
    var location: NSManagedObject?
    var marker: GMSMarker?

    init(frame: CGRect, tableView: UITableView, location: NSManagedObject, marker: GMSMarker) {
                
        super.init(frame: UIScreen.main.bounds)

        self.backgroundColor = .clear
        self.layer.cornerRadius = 20.0
        self.location = location
        self.marker = marker
        
        tableView.register(UITableViewCell.self, forCellReuseIdentifier: "Cell")
        tableView.frame = CGRect(x: self.frame.origin.x, y: self.frame.origin.y + 30, width: self.frame.width, height: self.frame.height)
        tableView.isUserInteractionEnabled = true
        tableView.delegate = self
        tableView.dataSource = self
        
        
        self.addSubview(tableView)
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
}

extension SettingsView: UITableViewDelegate, UITableViewDataSource {
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        5
    }
    
    
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        
        let cell = tableView.dequeueReusableCell(withIdentifier: "Cell", for: indexPath)
        cell.backgroundColor = #colorLiteral(red: 0.1411764771, green: 0.3960784376, blue: 0.5647059083, alpha: 1)
        cell.textLabel?.textColor = .white
        
        switch indexPath.row {
        case 0: cell.textLabel?.text = "Marker settings:"
        case 1: cell.addSubview(self.firstCell(cell))
        case 2: cell.addSubview(self.secondCell(cell))
        case 3: cell.addSubview(self.thirdCell())
        default: break
        }
        
        return cell
    }

}

extension SettingsView: UITextFieldDelegate, PlacementOnLocation {
    
    
    func textFieldShouldReturn(_ textField: UITextField) -> Bool {
        self.endEditing(true)
        
        guard textField.text != nil else { return false }
        
        self.markerChangeTitle(entity: self.location ?? NSManagedObject(), name: textField.text ?? "")
        
        self.marker?.title = textField.text
        return true
    }
    
}

extension SettingsView {
    func firstCell(_ cell: UITableViewCell) -> UITextField {
        let firstCellTextfield = UITextField()
        firstCellTextfield.delegate = self
        firstCellTextfield.frame = CGRect(x: cell.frame.origin.x + 20, y: cell.frame.origin.y, width: cell.frame.width, height: cell.frame.height)
        firstCellTextfield.backgroundColor = .clear
        firstCellTextfield.keyboardType = .default
        firstCellTextfield.returnKeyType = .done
        firstCellTextfield.enablesReturnKeyAutomatically = true
        firstCellTextfield.textColor = .white
        firstCellTextfield.textAlignment = .center
        firstCellTextfield.text = self.location?.value(forKey: CoreDataValues.attributeName.rawValue) as? String
        return firstCellTextfield
    }
    
    func secondCell(_ cell: UITableViewCell) -> UIPickerView {
        let secondCellPickerView = UIPickerView()
        secondCellPickerView.delegate = self
        secondCellPickerView.dataSource = self
        secondCellPickerView.frame = CGRect(x: cell.frame.origin.x + 20, y: cell.frame.origin.y, width: cell.frame.width, height: cell.frame.height)
        
        return secondCellPickerView
    }
    
    func thirdCell() -> UIButton {
        let buttonDone = UIButton()
        buttonDone.frame = CGRect(x: self.frame.origin.x + 20, y: self.frame.origin.y, width: 100, height: 40)
        buttonDone.layer.cornerRadius = 20
        buttonDone.backgroundColor = .white
        buttonDone.setAttributedTitle(NSAttributedString(string: "Delete"), for: .normal)
        buttonDone.titleLabel?.textColor = .black
        buttonDone.addTarget(self, action: #selector(buttonDonePressed), for: .touchUpInside)
        
        return buttonDone
    }
    
    @objc func buttonDonePressed() {
        self.markerDelete(entity: self.location ?? NSManagedObject(), marker: self.marker ?? GMSMarker())
    }
    
}

extension SettingsView: UIPickerViewDelegate, UIPickerViewDataSource {
    
        func numberOfComponents(in pickerView: UIPickerView) -> Int {
            1
        }
    
//    func pickerView(_ pickerView: UIPickerView, attributedTitleForRow row: Int, forComponent component: Int) -> NSAttributedString? {
//        
//        
//        var attributedString: NSAttributedString!
//
//                switch component {
//                case 0:
//                    attributedString = NSAttributedString(string: PinColor.Red.rawValue, attributes: [NSAttributedString.Key.foregroundColor : UIColor.red])
//                case 1:
//                    attributedString = NSAttributedString(string: PinColor.Violet.rawValue, attributes: [NSAttributedString.Key.foregroundColor : UIColor.violet])
//                case 2:
//                    attributedString = NSAttributedString(string: toString(arrayThree[row]), attributes: [NSForegroundColorAttributeName : UIColor.redColor()])
//                default:
//                    attributedString = nil
//                }
//
//                return attributedString
//        
//    }
    
        func pickerView(_ pickerView: UIPickerView, numberOfRowsInComponent component: Int) -> Int {
            return 7
        }
        
        func pickerView(_ pickerView: UIPickerView, titleForRow row: Int, forComponent component: Int) -> String? {
            switch row {
            case 0:
                return PinColor.Red.rawValue
            case 1:
                return PinColor.Violet.rawValue
            case 2:
                return PinColor.Blue.rawValue
            case 3:
                return PinColor.Black.rawValue
            case 4:
                return PinColor.Yellow.rawValue
            case 5:
                return PinColor.Green.rawValue
            default:
                return PinColor.Gray.rawValue
            }
        }
        
        func pickerView(_ pickerView: UIPickerView, didSelectRow row: Int, inComponent component: Int) {
            switch row {
            case 0:
                Color.shared.color = .Red
            case 1:
                Color.shared.color = .Violet
            case 2:
                Color.shared.color = .Blue
            case 3:
                Color.shared.color = .Black
            case 4:
                Color.shared.color = .Yellow
            case 5:
                Color.shared.color = .Green
            case 6:
                Color.shared.color = .Gray
            default:
                break
            }
        }
    
}
