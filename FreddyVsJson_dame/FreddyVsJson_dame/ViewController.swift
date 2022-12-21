//
//  ViewController.swift
//  FreddyVsJson_dame
//
//  Created by Dameion Dismuke on 12/20/22.
//

import UIKit

class ViewController: UIViewController, UITableViewDelegate, UITableViewDataSource {

    
    @IBOutlet weak var tableView: UITableView!
    
    
    var killers = [KillerStats]()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view.
        
        downloadJSON {
            self.tableView.reloadData()
        }
        
        tableView?.delegate = self
        tableView?.dataSource = self
        
    }
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return killers.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) ->
        UITableViewCell {
            let cell = UITableViewCell(style: .default, reuseIdentifier: nil)
            cell.textLabel?.text = killers[indexPath.row].name.capitalized
            
            return cell
            
        }
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        performSegue(withIdentifier: "showDetails", sender: self)
    }
    
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        if let destination = segue.destination as? KillerViewController{
            destination.killer = killers[(tableView.indexPathForSelectedRow?.row)!]
        }
    
    
    }
    
    
    func downloadJSON (completed: @escaping () -> ()){
        
        let url = URL(string: "https://dbd-api.herokuapp.com/killers")
        
        URLSession.shared.dataTask(with: url!){ (data, response, error) in
            
            if error == nil {
                do {
                    self.killers = try JSONDecoder().decode([KillerStats].self, from: data!)
                    
                    DispatchQueue.main.async {
                        completed()
                    }
                    
                } catch {
                    print("JSON ERROR")
                }
            }
            
        }.resume()
        
        
    }


}

