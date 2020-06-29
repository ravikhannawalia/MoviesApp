//
//  SearchPage.swift
//  MovieBrowser
//
//  Created by Ravi Khannawalia on 28/06/20.
//  Copyright © 2020 Frontend. All rights reserved.
//

import UIKit

/*
 TASKS Left
    Finish Movie page
    Image Loader
    Make better UI
 */

class SearchPage: UIViewController, UICollectionViewDataSource, UICollectionViewDelegate{
    
    @IBOutlet weak var collectionView: UICollectionView!
    @IBOutlet weak var stackView: UIStackView!
    
    let service = MovieDBService()
    var searchResults = [SearchResults]()
    let searchController = UISearchController(searchResultsController: nil)
    
    private let itemsPerRow: CGFloat = 3
    private let sectionInsets = UIEdgeInsets(top: 5.0, left: 40.0, bottom: 5.0, right: 40.0)
    var page = 1

    override func viewDidLoad() {
        super.viewDidLoad()
        
        // Do any additional setup after loading the view.        loadMovies()
        
        initialSetup()
        loadMovies()
        
    }
    
    func numberOfSections(in collectionView: UICollectionView) -> Int {
        return 1
    }
    
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return searchResults.count
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        guard let cell = collectionView.dequeueReusableCell(withReuseIdentifier: "SearchResultCell", for: indexPath) as? SearchResultCell  else {
               fatalError("The dequeued cell is not an instance of SearchResultCell")
           }
        
        updateCell(cell: cell, indexPath: indexPath)
        loadNextPage(indexPath: indexPath)
        return cell
    }
    
    // MARK: - Navigation

    // In a storyboard-based application, you will often want to do a little preparation before navigation
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        guard let moviePage = segue.destination as? MoviePage else {
            fatalError("Unexpected destination: \(segue.destination)")
        }
        
        guard let searchCell = sender as? SearchResultCell else {
            fatalError("Unexpected sender: \(sender)")
        }
        
        guard let indexPath = collectionView.indexPath(for: searchCell) else {
            fatalError("The selected cell is not being displayed by the table")
        }
        
        let selectedMovie = searchResults[indexPath.row]
        moviePage.searchItem = selectedMovie
        moviePage.id = selectedMovie.id
    }

}

//Do Initial Setup
extension SearchPage{
    
    func initialSetup(){
        collectionView.delegate = self
        collectionView.dataSource = self
        collectionView.prefetchDataSource = self
        setUpNavBar()
    }
    
    func loadMovies(){
        service.fetchAllResults(searchString: Constants.popularMoviesURL, page: page){[weak self] results, error in
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

extension SearchPage: UISearchResultsUpdating {
    var isSearchBarEmpty: Bool {
      return searchController.searchBar.text?.isEmpty ?? true
    }
    
    func updateSearchResults(for searchController: UISearchController) {
    // TODO
    }
}

extension SearchPage{
    func updateCell(cell: SearchResultCell, indexPath: IndexPath){
        let searchItem = searchResults[indexPath.row]
        
        if let posterUrl = searchItem.posterUrl, let imageUrl = URL(string: Constants.imageURLInitial + posterUrl){
            cell.posterImage.kf.setImage(with: imageUrl){ a, b, c, d in
            //    cell.hideLoading()
            }
        }
    }
    
    func loadNextPage(indexPath: IndexPath){
        if indexPath.row == searchResults.count - 1 { // last cell
            loadMovies()
        }
    }
    
    private func setUpNavBar() {
        self.navigationController?.navigationBar.prefersLargeTitles = true
        self.title = "Movies Search"
        
        self.navigationItem.searchController = searchController
        self.navigationItem.hidesSearchBarWhenScrolling = false
        
        searchController.searchResultsUpdater = self as UISearchResultsUpdating
        definesPresentationContext = true
    }

}

extension SearchPage: UICollectionViewDelegateFlowLayout {
  func collectionView(_ collectionView: UICollectionView,
                      layout collectionViewLayout: UICollectionViewLayout,
                      sizeForItemAt indexPath: IndexPath) -> CGSize {
    
    let paddingSpace = sectionInsets.left * (itemsPerRow + 1)
    let availableWidth = view.frame.width - paddingSpace
    let widthPerItem = availableWidth / (itemsPerRow-1)
    
    return CGSize(width: widthPerItem, height: widthPerItem*2)
  }
}

extension SearchPage: UICollectionViewDataSourcePrefetching {
    func collectionView(_ collectionView: UICollectionView, prefetchItemsAt indexPaths: [IndexPath]) {
        print(indexPaths)
    }
    
    /*
    func collectionView(_ collectionView: UICollectionView, cancelPrefetchingForItemsAt indexPaths: [IndexPath]) {
        <#code#>
    }
 */
  
}
