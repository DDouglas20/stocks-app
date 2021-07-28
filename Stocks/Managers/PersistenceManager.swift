//
//  PersistenceManager.swift
//  Stocks
//
//  Created by DeQuan Douglas on 7/14/21.
//

import Foundation

final class PersistenceManager {
    static let shared = PersistenceManager()
    
    private let userDefaults: UserDefaults = .standard
    
    private struct Constants {
        
    }
    
    private init() {}
    
    //MARK: Private
    
    public var watchlist: [String] {
        return []
    }
    
    public func addToWatchlist() {
        
    }
    
    public func removeFromWatchlist() {
        
    }
    
    //MARK: Public
    
    private var hasOnboarded: Bool {
        return false
    }
}
