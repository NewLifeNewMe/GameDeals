//
//  GamesController.swift
//  GamePrices_storyboard
//
//  Created by Egor Moroz on 21.08.24.
//

import UIKit

class GamesController: UITableViewController {
    
    var games: Games = []

    override func viewDidLoad() {
        super.viewDidLoad()
        navigationItem.title = "Game Deals"
        navigationController?.navigationBar.prefersLargeTitles = true
        performRequest()
    }
    
    private func performRequest() {
        let request = Request(endpoint: .deals, queryParameters: [URLQueryItem(name: "storeID", value: "1"), URLQueryItem(name: "upperPrice", value: "15")])
        
        NetworkService.shared.execute(request, expecting: Games.self) { result in
            switch result {
            case .success(let games):
                DispatchQueue.main.async {
                    self.games = games
                    self.tableView.reloadData()
                }
            case .failure(let failure):
                print(String(describing: failure))
            }
        }
        
    }
}

extension GamesController {
    
    override func numberOfSections(in tableView: UITableView) -> Int {
        return 1
    }
    
    override func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        return 100
    }
    
    override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return games.count
    }
    
    override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "reuseIdentifier", for: indexPath) as! GameCell
        let gamesArray = games[indexPath.row]
        
        let attributedString: NSMutableAttributedString = NSMutableAttributedString(string: gamesArray.normalPrice!)
        attributedString.addAttribute(NSAttributedString.Key.strikethroughStyle, value: 2, range: NSRange(location: 0, length: attributedString.length))
        
        cell.nameLabel.text = gamesArray.title
        cell.priceLabel.text = "$" + gamesArray.salePrice!
        cell.oldPriceLabel.attributedText = attributedString
        cell.gameImage.downloaded(from: URL(string: gamesArray.thumb!)!)
        
        return cell
    }
    
}

