import UIKit

class SettingsView: UIView {
    init(frame: CGRect, color: UIColor, tableView: UITableView) {
                
        super.init(frame: UIScreen.main.bounds)
        
        self.backgroundColor = color
        self.layer.cornerRadius = 20.0
        
        tableView.register(UITableViewCell.self, forCellReuseIdentifier: "Cell")
        tableView.frame = CGRect(x: self.frame.origin.x, y: self.frame.origin.y + 30, width: self.frame.width, height: self.frame.height)
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
        20
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        
        let cell = tableView.dequeueReusableCell(withIdentifier: "Cell", for: indexPath)
        cell.backgroundColor = #colorLiteral(red: 0.1411764771, green: 0.3960784376, blue: 0.5647059083, alpha: 1)
        cell.textLabel?.textColor = .white
        cell.textLabel?.text = "don"
        
        
        return cell
    }
    
    
}
