//
//  KillerViewController.swift
//  FreddyVsJson_dame
//
//  Created by Dameion Dismuke on 12/20/22.
//

import UIKit

extension UIImageView {
    func downloaded(from url: URL, contentMode mode: ContentMode = .scaleAspectFit) {
        contentMode = mode
        URLSession.shared.dataTask(with: url) { data, response, error in
            guard
                let httpURLResponse = response as? HTTPURLResponse, httpURLResponse.statusCode == 200,
                let mimeType = response?.mimeType, mimeType.hasPrefix("image"),
                let data = data, error == nil,
                let image = UIImage(data: data)
                else { return }
            DispatchQueue.main.async() { [weak self] in
                self?.image = image
            }
        }.resume()
    }
    func downloaded(from link: String, contentMode mode: ContentMode = .scaleAspectFit) {
        guard let url = URL(string: link) else { return }
        downloaded(from: url, contentMode: mode)
    }
}


class KillerViewController: UIViewController {

    
    @IBOutlet weak var imageView: UIImageView!
    @IBOutlet weak var nameLbl: UILabel!
    @IBOutlet weak var nameTagLbl: UILabel!
    @IBOutlet weak var weaponLbl: UILabel!
    @IBOutlet weak var loreLbl: UILabel!
    
    
    
    var killer:KillerStats?
    
    
    override func viewDidLoad() {
        super.viewDidLoad()

        // Do any additional setup after loading the view.
        //JSON names
        
        nameLbl.text = killer?.name
        nameTagLbl.text = killer?.name_tag
        weaponLbl.text = killer?.weapon
        loreLbl.text = killer?.lore
        
        let urlString = "https://raw.githubusercontent.com/dearvoodoo/dbd/master/Killers/Portrait/\(killer?.name_tag).png"
        let url = URL(string: urlString)
        
        imageView.downloadedfrom(url: url!)
    }
    



}
