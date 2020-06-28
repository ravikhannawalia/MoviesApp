//
//  MoviePage.swift
//  MovieBrowser
//
//  Created by Ravi Khannawalia on 28/06/20.
//  Copyright © 2020 Frontend. All rights reserved.
//

import UIKit

class MoviePage: UIViewController {

    @IBOutlet weak var moviePoster: UIImageView!
    @IBOutlet weak var titleLabel: UILabel!
    @IBOutlet weak var overviewLabel: UILabel!
    
    var id: Int?
    let service = MovieDBService()
    
    var searchItem: SearchResults?
    
    override func viewDidLoad() {
        super.viewDidLoad()

        // Do any additional setup after loading the view.
        setupPage()
    }
    
    func setupPage(){
        guard let id = id else{
            fatalError("id is not good")
        }
        service.fetchMovieInfo(id: String(id)){ movie, error in
            
            if let error = error {
              print("Error searching : \(error)")
              return
            }
            
            if let movie = movie {
                if let posterUrl = movie.posterURL, let imageUrl = URL(string: Constants.imageURLInitial + posterUrl){
                    self.moviePoster.kf.setImage(with: imageUrl)
                }
            }
            self.titleLabel.text = movie?.title
            self.overviewLabel.text = movie?.overview
            
        }
    }
    

    /*
    // MARK: - Navigation

    // In a storyboard-based application, you will often want to do a little preparation before navigation
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        // Get the new view controller using segue.destination.
        // Pass the selected object to the new view controller.
    }
    */

}
