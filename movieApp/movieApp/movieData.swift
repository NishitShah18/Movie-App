//
//  movieData.swift
//  movieApp
//
//  Created by Nishit Shah on 2024-03-24.
//

import Foundation

class movieData
{
    static let newMovie = movieData(movieName: "",movieYear: "",moviePhoto: "",movieImdbID: "",movieURL: "")
    var movieName : String
    var movieYear : String
    var moviePhoto : String
    var movieImdbID : String
    var movieURL : String
    init(movieName: String, movieYear: String, moviePhoto: String, movieImdbID: String, movieURL: String) {
        self.movieName = movieName
        self.movieYear = movieYear
        self.moviePhoto = moviePhoto
        self.movieImdbID = movieImdbID
        self.movieURL = movieURL
    }
}
