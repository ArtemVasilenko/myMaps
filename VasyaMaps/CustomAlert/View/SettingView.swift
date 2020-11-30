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
        tableView.frame = CGRect(x: self.frame.origin.x, y: self.frame.origin.y + 5, width: self.frame.width, height: self.frame.height)
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
        4
    }
    
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        guard indexPath.row == 2 else { return 44 }
        
        return 88
        
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        
        let cell = tableView.dequeueReusableCell(withIdentifier: "Cell", for: indexPath)
        
        cell.backgroundColor = #colorLiteral(red: 0.1411764771, green: 0.3960784376, blue: 0.5647059083, alpha: 1)
        cell.textLabel?.textColor = .white
        
        switch indexPath.row {
        case 0: cell.textLabel?.text = "Marker settings:"
            cell.textLabel?.textAlignment = .center
        case 1: cell.addSubview(self.markerTitleTextField())
        case 2: cell.addSubview(self.markerColorPickerView())
        case 3: cell.addSubview(self.markerDeleteButton())
            cell.addSubview(self.doneButton())
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
    
    
    func markerTitleTextField() -> UITextField {
        let textField = UITextField()
        textField.delegate = self
        textField.frame = CGRect(x: 20, y: 0, width: 200, height: 44)
        textField.backgroundColor = .clear
        textField.keyboardType = .default
        textField.returnKeyType = .done
        textField.enablesReturnKeyAutomatically = true
        textField.textColor = .white
        textField.textAlignment = .center
        textField.text = self.location?.value(forKey: CoreDataValues.attributeName.rawValue) as? String
        return textField
    }
    
    func markerColorPickerView() -> UIPickerView {
        let picker = UIPickerView()
        picker.delegate = self
        picker.dataSource = self
        picker.frame = CGRect(x: 20, y: 0, width: 200, height: 88)
        
        
        
        return picker
    }
    
    func markerDeleteButton() -> UIButton {
        let button = UIButton()
        button.frame = CGRect(x: self.frame.origin.x + self.frame.width - 140, y: self.frame.origin.y, width: 100, height: 40)
        button.layer.cornerRadius = 20
        button.backgroundColor = .white
        button.setAttributedTitle(NSAttributedString(string: "Delete"), for: .normal)
        button.titleLabel?.textColor = .black
        button.addTarget(self, action: #selector(buttonDeletePressed), for: .touchUpInside)
        
        return button
    }
    
    @objc func buttonDeletePressed() {
        self.deleteAlert()
    }
    
    func doneButton() -> UIButton {
        let button = UIButton()
        button.frame = CGRect(x: 40, y: self.frame.origin.y, width: 100, height: 40)
        button.layer.cornerRadius = 20
        button.backgroundColor = .white
        button.setAttributedTitle(NSAttributedString(string: "Ok"), for: .normal)
        button.titleLabel?.textColor = .black
        button.addTarget(self, action: #selector(buttonDonePressed), for: .touchUpInside)
        
        return button
    }
    
    @objc func buttonDonePressed() {
    }
    
}

extension SettingsView: UIPickerViewDelegate, UIPickerViewDataSource {
    
    func numberOfComponents(in pickerView: UIPickerView) -> Int {
        1
    }
    
    func pickerView(_ pickerView: UIPickerView, attributedTitleForRow row: Int, forComponent component: Int) -> NSAttributedString? {
        
        var attributedString: NSAttributedString!
        
        switch row {
        case 0:
            attributedString = NSAttributedString(string: PinColor.Red.rawValue, attributes: [NSAttributedString.Key.foregroundColor : UIColor.red])
        case 1:
            attributedString = NSAttributedString(string: PinColor.Violet.rawValue, attributes: [NSAttributedString.Key.foregroundColor : UIColor.purple])
        case 2:
            attributedString = NSAttributedString(string: PinColor.Blue.rawValue, attributes: [NSAttributedString.Key.foregroundColor : UIColor.blue])
        case 3:
            attributedString = NSAttributedString(string: PinColor.Black.rawValue, attributes: [NSAttributedString.Key.foregroundColor : UIColor.black])
        case 4:
            attributedString = NSAttributedString(string: PinColor.Yellow.rawValue, attributes: [NSAttributedString.Key.foregroundColor : UIColor.yellow])
        case 5:
            attributedString = NSAttributedString(string: PinColor.Green.rawValue, attributes: [NSAttributedString.Key.foregroundColor : UIColor.green])
        case 6:
            attributedString = NSAttributedString(string: PinColor.Gray.rawValue, attributes: [NSAttributedString.Key.foregroundColor : UIColor.gray])
            
        default:
            attributedString = nil
        }
        
        return attributedString
        
    }
    
    func pickerView(_ pickerView: UIPickerView, numberOfRowsInComponent component: Int) -> Int {
        return 7
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

extension SettingsView {
    
    func deleteAlert() {
        
        let alert = UIAlertController(title: DeleteMarkerAlert.shared.title, message: DeleteMarkerAlert.shared.message, preferredStyle: .alert)
        
        
        let okAction = UIAlertAction(title: DeleteMarkerAlert.shared.okAction, style: .default) { (action) in
            
            self.markerDelete(entity: self.location ?? NSManagedObject(), marker: self.marker ?? GMSMarker())
            
        }
        
        let cancelAction = UIAlertAction(title: DeleteMarkerAlert.shared.cancelAction, style: .cancel, handler: nil)
        
        alert.addAction(cancelAction)
        alert.addAction(okAction)
        
        self.window?.rootViewController?.present(alert, animated: true, completion: nil)
    }
    
}
