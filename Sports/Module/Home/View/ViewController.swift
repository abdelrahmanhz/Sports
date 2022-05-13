//
//  ViewController.swift
//  Sports
//
//  Created by NourAllah Ahmed on 5/11/22.
//  Copyright © 2022 NourAllah Ahmed. All rights reserved.
//

import UIKit
import Kingfisher

protocol HomeProtocol: AnyObject {
    func renderCollection(sports: [Sports])
    func stopIndicator()
}

class ViewController: UIViewController {

    @IBOutlet weak var sportsCollection: UICollectionView!
    
    var Sports : [Sports]?
    var presenter: HomePresenter!
    let indicator = UIActivityIndicatorView(style: .large)
    
    override func viewDidLoad() {
        super.viewDidLoad()
        self.sportsCollection.delegate = self
        self.sportsCollection.dataSource = self
        // Do any additional setup after loading the view.
        indicator.center = self.view.center
        self.view.addSubview(indicator)
        indicator.startAnimating()
        
        presenter = HomePresenter(sportsService: NetworkSevice())
        presenter.attachView(view: self)
        presenter.getSports()

    }
}
extension ViewController : HomeProtocol{
    func renderCollection(sports: [Sports]) {
        self.Sports = sports
        self.sportsCollection.reloadData()
    }
    
    func stopIndicator() {
        indicator.stopAnimating()

    }
}
 
extension ViewController : UICollectionViewDataSource , UICollectionViewDelegate {
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return Sports?.count ?? 0
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        let cell = collectionView.dequeueReusableCell(withReuseIdentifier: "sportCell", for: indexPath) as! SportCustomCollectionViewCell
        
        cell.sportImage.image = UIImage(named: "default.png")
        let imageUrl = URL(string: Sports?[indexPath.row].strSportThumb ?? "")
        cell.sportImage.kf.setImage(with: imageUrl,
                                    placeholder: UIImage(named: "default.png") ,
                                    options: nil,
                                    progressBlock: nil)
        
        cell.sportLabel.text = Sports?[indexPath.row].strSport
        
        return cell
    }
    
    
}
