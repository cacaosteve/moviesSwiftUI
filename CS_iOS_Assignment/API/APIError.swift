//
//  APIError.swift
//  CS_iOS_Assignment
//
//  Created by steve on 12/26/20.
//
// Networking API by Alex Brown
// https://www.swiftcompiled.com/mvvm-swiftui-and-combine/

import Foundation

enum APIError: Error {
    case decodingError
    case httpError(Int)
    case unknown
}

