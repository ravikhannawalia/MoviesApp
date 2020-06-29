//
//  HomePageController.swift
//  MovieBrowser
//
//  Created by Ravi Khannawalia on 29/06/20.
//  Copyright © 2020 Frontend. All rights reserved.
//

import UIKit

class HomePageController: UIViewController {
    
    override func viewDidLoad() {
        super.viewDidLoad()
    }
    
    // MARK: - Navigation

    // In a storyboard-based application, you will often want to do a little preparation before navigation
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        guard let moviePage = segue.destination as? MoviePage else {
            fatalError("Unexpected destination: \(segue.destination)")
        }
        
        guard let movieCell = sender as? HomeMovieCell else {
            fatalError("Unexpected sender: \(sender)")
        }
        
        moviePage.id = movieCell.id ?? -1
        
        // Get the new view controller using segue.destination.
        // Pass the selected object to the new view controller.
    }
    

}

extension HomePageController: UITableViewDelegate, UITableViewDataSource {
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return Constants.genres.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        
        guard let cell = tableView.dequeueReusableCell(withIdentifier: "HomeTableViewCell", for: indexPath) as? HomeTableViewCell else {
            fatalError("Cell not of type HomeTableViewCell")
        }
        
        updateCell(cell: cell, indexPath: indexPath)
        return cell
    }
    
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        return 250
    }
}

extension HomePageController {
    func updateCell(cell: HomeTableViewCell, indexPath: IndexPath) {
        let genreID = Constants.genres.keys.sorted(by: < )[indexPath.row]
        cell.genreLabel.text = Constants.genres[genreID]
        cell.genreID = genreID
        cell.loadMovies()
    }
}

