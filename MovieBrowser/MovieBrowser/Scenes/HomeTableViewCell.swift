//
//  HomeTableViewCell.swift
//  MovieBrowser
//
//  Created by Ravi Khannawalia on 29/06/20.
//  Copyright © 2020 Frontend. All rights reserved.
//

import UIKit

class HomeTableViewCell: UITableViewCell {
    
    let service = MovieDBService()
    var page = 1
    var searchResults = [SearchResults]()

    @IBOutlet weak var genreLabel: UILabel!
    @IBOutlet weak var collectionView: UICollectionView!
    var genreID = ""
    
    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
        collectionView.delegate = self
        collectionView.dataSource = self
    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)
        
        // Configure the view for the selected state
    }

}

extension HomeTableViewCell: UICollectionViewDataSource, UICollectionViewDelegate, UICollectionViewDelegateFlowLayout {
    
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        searchResults.count
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        guard let cell = collectionView.dequeueReusableCell(withReuseIdentifier: "HomeMovieCell", for: indexPath) as? HomeMovieCell else {
            fatalError("Cell not of type HomeMovieCell")
        }
        updateCell(cell: cell, indexPath: indexPath)
        loadNextPage(indexPath: indexPath)
        return cell
    }
    
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAt indexPath: IndexPath) -> CGSize {
        
        return CGSize(width: collectionView.frame.height/2, height: collectionView.frame.height)
    }
}

extension HomeTableViewCell {
    func loadMovies(){
        service.fetchAllResults(searchString: Constants.genresURLInitial + genreID, page: page){[weak self] results, error in
            if let error = error {
              print("Error searching : \(error)")
              return
            }

            if let results = results {
                self?.searchResults += results
                self?.collectionView?.reloadData()
                self?.page += 1
            }
        }
    }
}

extension HomeTableViewCell {
    func updateCell(cell: HomeMovieCell, indexPath: IndexPath){
        
        if(searchResults.count==0){
            print("No cell")
            return
        }
        
        let searchItem = searchResults[indexPath.row]
        if let posterUrl = searchItem.posterUrl, let imageUrl = URL(string: Constants.imageURLInitial2 + posterUrl){
            cell.id = searchItem.id
            cell.posterImage.kf.setImage(with: imageUrl)
        }
    }
    
    func loadNextPage(indexPath: IndexPath){
        if indexPath.row == searchResults.count - 1 { // last cell
            loadMovies()
        }
    }
}
