//
//  ViewController.swift
//  movieApp
//
//  Created by Nishit Shah on 2024-03-24.
//

import UIKit

class ViewController: UIViewController {

    @IBOutlet var myTable: UITableView!
    
    var listMovie = [movieData]()
    var searching = false
    var searchedMovie = [movieData]()
    
    let searchController = UISearchController(searchResultsController: nil)
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        // Local data source
        let movie1 = movieData(movieName: "Iron Man 1", movieYear: "2008", moviePhoto: "1_ironMan1", movieImdbID: "TT0371746", movieURL: "https://www.imdb.com/title/tt0371746/")
        listMovie.append(movie1)
        let movie2 = movieData(movieName: "The Hulk", movieYear: "2008", moviePhoto: "2_Hulk", movieImdbID: "TT0800080", movieURL: "https://www.imdb.com/title/tt0800080/")
        listMovie.append(movie2)
        let movie3 = movieData(movieName: "Iron Man 2", movieYear: "2010", moviePhoto: "3_ironMan2", movieImdbID: "TT1228705", movieURL: "https://www.imdb.com/title/tt1228705/")
        listMovie.append(movie3)
        let movie4 = movieData(movieName: "Thor", movieYear: "2011", moviePhoto: "4_Thor1", movieImdbID: "TT0800369", movieURL: "https://www.imdb.com/title/tt0800369/")
        listMovie.append(movie4)
        let movie5 = movieData(movieName: "Captain America", movieYear: "2011", moviePhoto: "5_CapAme1", movieImdbID: "TT0458339", movieURL: "https://www.imdb.com/title/tt0458339/")
        listMovie.append(movie5)
        let movie6 = movieData(movieName: "The Avengers", movieYear: "2012", moviePhoto: "6_Avengers1", movieImdbID: "TT0848228", movieURL: "https://www.imdb.com/title/tt0848228/")
        listMovie.append(movie6)
        
        configureSearchController()
    }
    
    
    private func configureSearchController()
    {
        searchController.loadViewIfNeeded()
        searchController.searchResultsUpdater = self
        searchController.searchBar.delegate = self
        searchController.obscuresBackgroundDuringPresentation = false
        searchController.searchBar.enablesReturnKeyAutomatically = false
        searchController.searchBar.returnKeyType = UIReturnKeyType.done
        self.navigationItem.searchController = searchController
        self.navigationItem.hidesSearchBarWhenScrolling = false
        definesPresentationContext = true
        searchController.searchBar.placeholder = "Search Movie By Name"
    }
    
    @IBAction func addMovie() {
        if let vx = storyboard?.instantiateViewController(identifier: "newMovieVC") as? newMovie{
            self.navigationController?.pushViewController(vx, animated: true)
        }
    }
    
    @IBAction func reload() {
        print("reload")
        if movieData.newMovie.movieName.isEmpty
        {
            print("Nothing to print")
        }
        else
        {
            print("reloaded")
            listMovie.append(movieData.newMovie)
            myTable.reloadData()
        }
    }
    
    
}

extension ViewController: UITableViewDelegate, UITableViewDataSource, UISearchResultsUpdating, UISearchBarDelegate
{
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        if searching
        {
            return searchedMovie.count
        }
        else
        {
            return listMovie.count
        }
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = myTable.dequeueReusableCell(withIdentifier: "cell", for: indexPath) as! MyTableViewCell
        if searching
        {
            cell.movieNameLabel.text = searchedMovie[indexPath.row].movieName
            cell.movieImageView.image = UIImage(named: searchedMovie[indexPath.row].moviePhoto)
            cell.yearLabel.text = searchedMovie[indexPath.row].movieYear
        }
        else
        {
            cell.movieNameLabel.text = listMovie[indexPath.row].movieName
            cell.movieImageView.image = UIImage(named: listMovie[indexPath.row].moviePhoto)
            cell.yearLabel.text = listMovie[indexPath.row].movieYear
        }
        
        return cell;
    }
    
    func searchBarCancelButtonClicked(_ searchBar: UISearchBar) {
        searching = false
        searchedMovie.removeAll()
        myTable.reloadData()
    }
    
    func updateSearchResults(for searchController: UISearchController) {
        let searchText = searchController.searchBar.text!
        
        if !searchText.isEmpty
        {
            searching = true
            searchedMovie.removeAll()
            for movie in listMovie
            {
                if movie.movieName.lowercased().contains(searchText.lowercased())
                {
                    searchedMovie.append(movie)
                }
            }
        }
        else
        {
            searching = false
            searchedMovie.removeAll()
            searchedMovie = listMovie
        }
        
        myTable.reloadData()
    }
    
    func tableView(_ tableView: UITableView, editingStyleForRowAt indexPath: IndexPath) -> UITableViewCell.EditingStyle {
        return .delete
    }
    
    func tableView(_ tableView: UITableView, commit editingStyle: UITableViewCell.EditingStyle, forRowAt indexPath: IndexPath) {
        if editingStyle == .delete {
                // Present confirmation alert
                let alert = UIAlertController(title: "Confirm Deletion", message: "Are you sure you want to delete this movie?", preferredStyle: .alert)
                alert.addAction(UIAlertAction(title: "Cancel", style: .cancel, handler: nil))
                alert.addAction(UIAlertAction(title: "Delete", style: .destructive, handler: { action in
                    tableView.beginUpdates()
                    self.listMovie.remove(at: indexPath.row)
                    tableView.deleteRows(at: [indexPath], with: .fade)
                    tableView.endUpdates()
                }))
                self.present(alert, animated: true, completion: nil)
            }
    }
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        if let vc = storyboard?.
            
            
            instantiateViewController(identifier: "movieDetails") as? movieDeatils{
            vc.img = listMovie[indexPath.row].moviePhoto
            vc.id = listMovie[indexPath.row].movieImdbID
            vc.link = listMovie[indexPath.row].movieURL
            vc.name = listMovie[indexPath.row].movieName
            vc.year = listMovie[indexPath.row].movieYear
            self.navigationController?.pushViewController(vc, animated: true)
        }
    }
    
    
}

