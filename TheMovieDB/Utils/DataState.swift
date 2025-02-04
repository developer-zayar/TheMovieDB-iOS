//
//  DataState.swift
//  TheMovieDB
//
//  Created by Zay Yar Phyo on 26/01/2025.
//

enum DataState<T> {
    case idle
    case loading
    case success(T)
    case error(String?)
}
