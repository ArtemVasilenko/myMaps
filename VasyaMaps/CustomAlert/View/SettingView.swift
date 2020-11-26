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
        
        changeAttribute(entity: self.location ?? NSManagedObject(), name: textField.text ?? "")
        
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
        firstCellTextfield.text = self.location?.value(forKey: CoreDataValues.attributeName.rawValue) as? String
        return firstCellTextfield
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
        deleteMarker(entity: self.location ?? NSManagedObject(), marker: self.marker ?? GMSMarker())        
    }
    
}
