//
//  APIService.swift
//  CS_iOS_Assignment
//
//  Created by steve on 12/26/20.
//
// Networking API by Alex Brown
// https://www.swiftcompiled.com/mvvm-swiftui-and-combine/

import Foundation
import Combine
import UIKit

protocol APIService {
    func request<T: Decodable>(with builder: RequestBuilder) -> AnyPublisher<T, APIError>
}
