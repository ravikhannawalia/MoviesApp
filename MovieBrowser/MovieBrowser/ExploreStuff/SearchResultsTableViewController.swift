//
//  SearchResultsTableViewController.swift
//  MovieBrowser
//
//  Created by Frontend on 6/23/20.
//  Copyright © 2020 Frontend. All rights reserved.
//

import UIKit

enum jsonErrors: Error{
    case dataIsEmpty
    case jsonSerializationError
}

class SearchResultsTableViewController: UITableViewController {
    
    var searchItems = [SearchResults]()
    
    //MARK: Private Methods
    
    func loadData() {
        let dataApi = "https://api.themoviedb.org/3/discover/movie?api_key=6efc6c93672b8344194653f00432454f&sort_by=popularity.desc&page=2"
        if let url = URL(string: dataApi) {
           URLSession.shared.dataTask(with: url) {[weak self] data, response, error in
                
            guard let data = data else{
                    print("Error")
                    return
                }
            guard let jsonData = try? JSONSerialization.jsonObject(with: data, options: []) else{
                    print("Error")
                    return
            }
            
            guard let jsonDict = jsonData as? [String: Any],
                let jsonArray = jsonDict["results"] as? [Any] else{
                    print("jsonDictError")
                    return
            }
            for item in jsonArray{
                if let searchDict = item as? [String: Any] {
                    let title = searchDict["title"] as? String
                    let id = searchDict["id"] as? Int
                    let posterUrl = searchDict["poster_path"] as? String
                    if let title = title, let id = id, let posterUrl = posterUrl{
                        let searchItem = SearchResults(title: title, id: id, posterUrl: posterUrl)
                        self?.searchItems.append(searchItem)
                    }
                    else{
                        print("Error in item")
                    }
                }
            }
            DispatchQueue.main.async {
                self?.tableView.reloadData()
            }
           }.resume()
        }
    }

    override func viewDidLoad() {
        super.viewDidLoad()
        
        loadData()
    }

    // MARK: - Table view data source

    override func numberOfSections(in tableView: UITableView) -> Int {
        return 1
    }

    override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return searchItems.count
    }

    
    override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        guard let cell = tableView.dequeueReusableCell(withIdentifier: "SearchResultTableViewCell", for: indexPath) as? SearchResultTableViewCell else {
            fatalError("The dequeued cell is not an instance of MealTableViewCell.")
        }
        let searchItem = searchItems[indexPath.row]
        
        // Configure the cell...
        cell.movieID.text = String(searchItem.id!)
        cell.movieTitle.text = searchItem.title

        return cell
    }

    /*
    // Override to support conditional editing of the table view.
    override func tableView(_ tableView: UITableView, canEditRowAt indexPath: IndexPath) -> Bool {
        // Return false if you do not want the specified item to be editable.
        return true
    }
    */

    /*
    // Override to support editing the table view.
    override func tableView(_ tableView: UITableView, commit editingStyle: UITableViewCell.EditingStyle, forRowAt indexPath: IndexPath) {
        if editingStyle == .delete {
            // Delete the row from the data source
            tableView.deleteRows(at: [indexPath], with: .fade)
        } else if editingStyle == .insert {
            // Create a new instance of the appropriate class, insert it into the array, and add a new row to the table view
        }    
    }
    */

    /*
    // Override to support rearranging the table view.
    override func tableView(_ tableView: UITableView, moveRowAt fromIndexPath: IndexPath, to: IndexPath) {

    }
    */

    /*
    // Override to support conditional rearranging of the table view.
    override func tableView(_ tableView: UITableView, canMoveRowAt indexPath: IndexPath) -> Bool {
        // Return false if you do not want the item to be re-orderable.
        return true
    }
    */

    /*
    // MARK: - Navigation

    // In a storyboard-based application, you will often want to do a little preparation before navigation
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        // Get the new view controller using segue.destination.
        // Pass the selected object to the new view controller.
    }
    */

}
