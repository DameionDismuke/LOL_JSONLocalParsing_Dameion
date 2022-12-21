//
//  ViewController.swift
//  LOL_JSONlocal_dame
//
//  Created by Dameion Dismuke on 12/21/22.
//

import UIKit

class ViewController: UIViewController,  UITableViewDelegate, UITableViewDataSource {
    
    
    var result: Result?
    
    
    public let tableView: UITableView = {
        let table = UITableView(
            frame: .zero,
            style: .grouped)
        
        table.register(UITableViewCell.self, forCellReuseIdentifier: "cell")
        return table
    }()
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        parseJSON()// Parsing it up now.
        view.addSubview(tableView)
        tableView.frame = view.bounds
        tableView.delegate = self
        tableView.dataSource = self
        
    }
    
    //TableView RIGHT HERE!!!
    
    func numberOfSections(in tableView: UITableView) -> Int {
        return result?.data.count ?? 0
    }
    
    func tableView(_ tableView: UITableView, titleForHeaderInSection section: Int) -> String? {
        return result?.data[section].name
    }
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        if let result = result {
            return result.data[section].tags.count
        }
        return 0
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let text = result?.data[indexPath.section].tags[indexPath.row]
        let cell = tableView.dequeueReusableCell(withIdentifier: "cell", for: indexPath)
        cell.textLabel?.text = text
        return cell
    }
    
    
    
    
    
    
    
    
    
    
    // JSON RIGHT HERE!!!!!
    
    func parseJSON(){
        guard let path = Bundle.main.path(forResource: "lol-champions", ofType: "json")
        else {
            return
        }
        
        
        let url = URL(fileURLWithPath: path)
        
        
        
        do {
            let jsonData = try Data(contentsOf: url)
            result = try JSONDecoder().decode(Result.self, from: jsonData)
            
            
          /*  if let result = result {
                print(result)
            }
            else {
                print("Failed to Parse")
            }
            return
            */
        }
        catch {
            print("Error \(error)")
        }
    }
    
    
    
    
}

