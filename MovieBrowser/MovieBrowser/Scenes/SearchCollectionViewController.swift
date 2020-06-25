//
//  SearchCollectionViewController.swift
//  MovieBrowser
//
//  Created by Frontend on 6/24/20.
//  Copyright © 2020 Frontend. All rights reserved.
//

import UIKit
import Alamofire

private let reuseIdentifier = "SearchResultCell"

class SearchCollectionViewController: UICollectionViewController {
    
    var searchItems = Array<SearchResults>()
    let popularMoviesURL = "https://api.themoviedb.org/3/discover/movie?api_key=6efc6c93672b8344194653f00432454f&language=en-US&sort_by=popularity.desc&include_adult=true&include_video=false&page=1"
    let searchUrlInitial = "https://api.themoviedb.org/3/search/movie?api_key=6efc6c93672b8344194653f00432454f&language=en-US&page=1&include_adult=true&query="
    let imageURLInitial = "https://image.tmdb.org/t/p/w500/"

    override func viewDidLoad() {
        super.viewDidLoad()

        // Uncomment the following line to preserve selection between presentations
        // self.clearsSelectionOnViewWillAppear = false

        // Do any additional setup after loading the view.
        setupNavBar()
        fetchMovies(apiUrl: popularMoviesURL)
    }
    
    
    // MARK: Initial Setup
    
    func setupNavBar(){
        navigationController?.navigationBar.prefersLargeTitles = true

        let searchController = UISearchController(searchResultsController: nil)
        navigationItem.searchController = searchController
        
        searchController.searchResultsUpdater = self
        // 2
        searchController.obscuresBackgroundDuringPresentation = false
        // 3
        searchController.searchBar.placeholder = "Search Movies or TV"
        // 4
        navigationItem.searchController = searchController
        // 5
        definesPresentationContext = true
    }
    
    func fetchMovies(apiUrl: String){
        AF.request(apiUrl)
            .validate()
            .responseDecodable(of: AllResults.self){
            [weak self] response in
            guard let movies = response.value, let self = self else { return }
                if let results = movies.results{
                    self.searchItems = results
                    self.collectionView.reloadData()
            } else{
                print("Error while parsing JSON")
            }
        }
    }

    /*
    // MARK: - Navigation

    // In a storyboard-based application, you will often want to do a little preparation before navigation
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        // Get the new view controller using [segue destinationViewController].
        // Pass the selected object to the new view controller.
    }
    */

    // MARK: UICollectionViewDataSource

    override func numberOfSections(in collectionView: UICollectionView) -> Int {
        // #warning Incomplete implementation, return the number of sections
        return 1
    }


    override func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        // #warning Incomplete implementation, return the number of items
        return searchItems.count
    }

    override func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        guard let cell = collectionView.dequeueReusableCell(withReuseIdentifier: reuseIdentifier, for: indexPath) as? SearchResultCell else{
            fatalError("Cell not of type SearchResult")
        }
    
        // Configure the cell

        if let posterUrl = searchItems[indexPath.row].posterUrl{
            AF.download(imageURLInitial + posterUrl).responseData { [weak cell] response in
                if let data = response.value {
                    let image = UIImage(data: data)
                    cell?.posterImage.image = image
                    cell?.titleLabel.text = self.searchItems[indexPath.row].title
                    cell?.idLabel.text =  String(self.searchItems[indexPath.row].voteCount ?? -1)
                }
            }
            
        }
    
        return cell
    }

    // MARK: UICollectionViewDelegate

    /*
    // Uncomment this method to specify if the specified item should be highlighted during tracking
    override func collectionView(_ collectionView: UICollectionView, shouldHighlightItemAt indexPath: IndexPath) -> Bool {
        return true
    }
    */

    /*
    // Uncomment this method to specify if the specified item should be selected
    override func collectionView(_ collectionView: UICollectionView, shouldSelectItemAt indexPath: IndexPath) -> Bool {
        return true
    }
    */

    /*
    // Uncomment these methods to specify if an action menu should be displayed for the specified item, and react to actions performed on the item
    override func collectionView(_ collectionView: UICollectionView, shouldShowMenuForItemAt indexPath: IndexPath) -> Bool {
        return false
    }

    override func collectionView(_ collectionView: UICollectionView, canPerformAction action: Selector, forItemAt indexPath: IndexPath, withSender sender: Any?) -> Bool {
        return false
    }

    override func collectionView(_ collectionView: UICollectionView, performAction action: Selector, forItemAt indexPath: IndexPath, withSender sender: Any?) {
    
    }
    */

}

extension SearchCollectionViewController : UISearchResultsUpdating {
    func updateSearchResults(for searchController: UISearchController) {
        print("Updating")
        let searchBar = searchController.searchBar
        if searchBar.text! != "" {
            guard let searchURL = (searchUrlInitial + searchBar.text!).addingPercentEncoding(withAllowedCharacters: .urlQueryAllowed) else{
                fatalError("Weird UISearchError")
            }
            fetchMovies(apiUrl: searchURL)
        }
        else{
            fetchMovies(apiUrl: popularMoviesURL)
        }
    }
}
