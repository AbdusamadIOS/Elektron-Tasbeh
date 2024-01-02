//
//  MainVC.swift
//  Elektron Tasbeh
//
//  Created by Abdusamad Mamasoliyev on 27/05/23.
//

import UIKit

class MainVC: UIViewController {
    
    @IBOutlet weak var xisoblashLbl: UILabel!
    @IBOutlet weak var blurView: UIVisualEffectView!
    @IBOutlet weak var clearHistoryBtn: UIButton!
    @IBOutlet weak var historyViewOpen: UIView!
    @IBOutlet weak var colorWell: UIColorWell!
    @IBOutlet weak var contaneirView: UIView!
    @IBOutlet weak var raqamLbl: UILabel!
    @IBOutlet weak var addBtn: UIButton!
    @IBOutlet weak var tableView: UITableView!
    
    var histories: [History] = []
//    let defaults = UserDefaults.standard
    
    override func viewDidLoad() {
        super.viewDidLoad()

        setupSettingAll()
        setupNavBar()
        setupTableView()
        saveData(array: histories, nom: "histories")
        histories = getData(nom: "histories")
        histories = getData(nom: "histories")
        
    }
    
    func setupTableView() {
        
        tableView.dataSource = self
        tableView.delegate = self
        tableView.register(UINib(nibName: "HistoryCell", bundle: nil), forCellReuseIdentifier: "HistoryCell")
        
    }
    
    // MARK: UINavigationController
    
    func setupNavBar() {
        
        navigationItem.title =  "Calculation"
        let navigationBarAppearance = UINavigationBarAppearance()
        
        navigationBarAppearance.titleTextAttributes = [NSAttributedString.Key.foregroundColor: UIColor.white,
                                                       NSAttributedString.Key.font: UIFont.systemFont(ofSize: 25, weight: .bold) ]
        navigationItem.standardAppearance = navigationBarAppearance

        let tarix = UIBarButtonItem(image: UIImage(systemName:  "sidebar.left"), style: .plain, target: self, action: #selector(tarixBtn))
        
        let refresh = UIBarButtonItem(image: UIImage(systemName: "arrow.clockwise"), style: .done, target: self, action: #selector(refreshBtn))
        
        navigationItem.leftBarButtonItem = tarix
        navigationItem.rightBarButtonItem = refresh

        if view.backgroundColor == .white {
            
            tarix.tintColor = .black
            refresh.tintColor = .black
            
        } else if view.backgroundColor != .white {
            
            tarix.tintColor = .white
            refresh.tintColor = .white
        }
    }
    
    @objc func tarixBtn() {
        
        if historyViewOpen.isHidden == true {
            historyViewOpen.isHidden = false
            tableView.isHidden = false
            blurView.isHidden = false
            historyViewOpen.frame = CGRect(x: 0, y: 0, width: 0, height: Int(self.view.frame.height))
            tableView.frame = CGRect(x: 0, y: 0, width: 0, height: Int(self.view.frame.height))
            blurView.frame = CGRect(x: 0, y: 0, width: 0, height: Int(view.frame.height))
            UIView.animate(withDuration: 0.3) {
                self.historyViewOpen.frame = CGRect(x: 0, y: 0, width: (Int(self.view.frame.width) / 2), height: Int(self.view.frame.height))
                self.tableView.frame = CGRect(x: 0, y: 0, width: (Int(self.view.frame.width) / 2), height: Int(self.view.frame.height))
                self.blurView.frame = CGRect(x: 0, y: 0, width: (Int(self.view.frame.width) / 3), height: Int(self.view.frame.height))
            }
        }else{
            historyViewOpen.isHidden = true
            tableView.isHidden = true
            blurView.isHidden = true
            historyViewOpen.frame = CGRect(x: 0, y: 0, width: 0, height: Int(self.view.frame.height))
            tableView.frame = CGRect(x: 0, y: 0, width: 0, height: Int(self.view.frame.height))
            blurView.frame = CGRect(x: 0, y: 0, width: 0, height: Int(view.frame.height))
            UIView.animate(withDuration: 0.3) {
                self.historyViewOpen.frame = CGRect(x: 0, y: 0, width: (Int(self.view.frame.width) / 2), height: Int(self.view.frame.height))
                self.tableView.frame = CGRect(x: 0, y: 0, width: (Int(self.view.frame.width) / 2), height: Int(self.view.frame.height))
                self.blurView.frame = CGRect(x: 0, y: 0, width: (Int(self.view.frame.width) / 3), height: Int(self.view.frame.height))
            }
        }
    }
    
    @objc func refreshBtn() {
        
        if raqamLbl.text == "0" {
            raqamLbl.text = "0"
        }else{
            let history = History(text: Int(raqamLbl.text ?? "0")!)
            self.histories.append(history)
            self.saveData(array: self.histories, nom: "histories")
            tableView.reloadData()
            
            raqamLbl.text?.removeFirst()
            raqamLbl.text = "0"
        }
    }
    
    @IBAction func clearHistroyBtn(_ sender: UIButton) {
        
        self.histories.removeAll()
        self.tableView.reloadData()
        self.saveData(array: self.histories , nom: "histories")
    }
    
    func setupSettingAll() {
        
        contaneirView.layer.cornerRadius = 20
        contaneirView.layer.borderColor = UIColor.black.cgColor
        contaneirView.layer.borderWidth = 1
        addBtn.layer.borderColor = UIColor.black.cgColor
        addBtn.layer.borderWidth = 1
        addBtn.layer.cornerRadius = 20
        clearHistoryBtn.layer.borderColor = UIColor.red.cgColor
        clearHistoryBtn.layer.cornerRadius = 10
        clearHistoryBtn.layer.borderWidth = 0.7
        colorWell.title = "Color"
        colorWell.selectedColor = .systemCyan
        colorWell.addTarget(self, action: #selector(ColorChanged), for: .valueChanged)

    }
    
    @objc func ColorChanged() {
         
        view.backgroundColor = colorWell.selectedColor
                
    }
    
    @IBAction func addPressBtn(_ sender: UIButton) {
        
        let addOne: Int = Int(raqamLbl.text!)! + 1
        
        raqamLbl.text = "\(addOne)"
        
        self.reloadInputViews()
    }
    // MARK: UserDefault
    
    func saveData(array: [History], nom: String) {

        let encoder = JSONEncoder()

        if let encodedData = try? encoder.encode(array) {

            UserDefaults.standard.set(encodedData, forKey: nom)

        }
    }
    func getData( nom: String ) ->  [History] {

        let decoder = JSONDecoder()

        if let userData = UserDefaults.standard.data(forKey: nom) {

            if let decodedData = try? decoder.decode([History].self, from: userData) {
              return decodedData
            }
        }
        return []
    }
    
    

    // MARK: UIcolor to Hex Color
    func hexStringFromColor(color: UIColor) -> String {
        let components = color.cgColor.components
        let r: CGFloat = components?[0] ?? 0.0
        let g: CGFloat = components?[1] ?? 0.0
        let b: CGFloat = components?[2] ?? 0.0

        let hexString = String.init(format: "#%02lX%02lX%02lX", lroundf(Float(r * 255)), lroundf(Float(g * 255)), lroundf(Float(b * 255)))
        print(hexString)
        return hexString
     }

    func colorWithHexString(hexString: String) -> UIColor {
        var colorString = hexString.trimmingCharacters(in: .whitespacesAndNewlines)
        colorString = colorString.replacingOccurrences(of: "#", with: "").uppercased()

        print(colorString)
        let alpha: CGFloat = 1.0
        let red: CGFloat = self.colorComponentFrom(colorString: colorString, start: 0, length: 2)
        let green: CGFloat = self.colorComponentFrom(colorString: colorString, start: 2, length: 2)
        let blue: CGFloat = self.colorComponentFrom(colorString: colorString, start: 4, length: 2)

        let color = UIColor(red: red, green: green, blue: blue, alpha: alpha)
        return color
    }

    func colorComponentFrom(colorString: String, start: Int, length: Int) -> CGFloat {

        let startIndex = colorString.index(colorString.startIndex, offsetBy: start)
        let endIndex = colorString.index(startIndex, offsetBy: length)
        let subString = colorString[startIndex..<endIndex]
        let fullHexString = length == 2 ? subString : "\(subString)\(subString)"
        var hexComponent: UInt32 = 0

        guard Scanner(string: String(fullHexString)).scanHexInt32(&hexComponent) else {
            return 0
        }
        let hexFloat: CGFloat = CGFloat(hexComponent)
        let floatValue: CGFloat = CGFloat(hexFloat / 255.0)
        print(floatValue)
        return floatValue
    }
}
    // MARK: UITableView
extension MainVC: UITableViewDelegate, UITableViewDataSource {
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        histories.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
    
        let cell = tableView.dequeueReusableCell(withIdentifier: "HistoryCell") as! HistoryCell
        
        cell.titleLbl.text = String(histories[indexPath.row].text)
        
        return cell
    }
    
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        40
    }
}


