//
//  APIHandler.swift
//  FootballLeagueApplication
//
//  Created by Michael Hany on 29/06/2024.
//

import Foundation

class NetworkManager {
    func fetchData(completion: @escaping (Result<[APIItem], Error>) -> Void) {
        guard let url = URL(string: "http://api.football-data.org/v4/competitions") else {
            completion(.failure(NSError(domain: "", code: 0, userInfo: [NSLocalizedDescriptionKey: "Invalid URL"])))
            return
        }
        
        let task = URLSession.shared.dataTask(with: url) { data, response, error in
            if let error = error {
                completion(.failure(error))
                return
            }
            
            guard let data = data else {
                completion(.failure(NSError(domain: "", code: 0, userInfo: [NSLocalizedDescriptionKey: "No data received"])))
                return
            }
            
            do {
                let items = try JSONDecoder().decode([APIItem].self, from: data)
                completion(.success(items))
            } catch {
                completion(.failure(error))
            }
        }
        
        task.resume()
    }
}
