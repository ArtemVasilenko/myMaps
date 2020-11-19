import UIKit
import CoreData

class SettingsView: UIView {
    var location: NSManagedObject?
    init(frame: CGRect, color: UIColor, tableView: UITableView, location: NSManagedObject) {
                
        super.init(frame: UIScreen.main.bounds)
        
        self.backgroundColor = color
        self.layer.cornerRadius = 20.0
        self.location = location
        
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
        4
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        
        let cell = tableView.dequeueReusableCell(withIdentifier: "Cell", for: indexPath)
        cell.backgroundColor = #colorLiteral(red: 0.1411764771, green: 0.3960784376, blue: 0.5647059083, alpha: 1)
        cell.textLabel?.textColor = .white
        
        let firstCellTextfield = UITextField()
        firstCellTextfield.delegate = self
        firstCellTextfield.frame = CGRect(x: cell.frame.origin.x + 20, y: cell.frame.origin.y, width: cell.frame.width, height: cell.frame.height)
        firstCellTextfield.backgroundColor = .clear
        firstCellTextfield.keyboardType = .default
        firstCellTextfield.returnKeyType = .done
        firstCellTextfield.enablesReturnKeyAutomatically = true
        firstCellTextfield.textColor = .white
        firstCellTextfield.text = self.location?.value(forKey: CoreDataValues.attributeName.rawValue) as? String
        
        
        switch indexPath.row {
        case 0: cell.textLabel?.text = "Marker settings:"
        case 1: cell.addSubview(firstCellTextfield)
                        
        default: break
        }
        
        return cell
    }
    
//    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
//        <#code#>
//    }
    
    
    
    
}

extension SettingsView: UITextFieldDelegate {
    
    func textFieldShouldReturn(_ textField: UITextField) -> Bool {
        self.endEditing(true)
        return false
    }
    
}
