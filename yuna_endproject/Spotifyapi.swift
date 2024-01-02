//  Spotifyapi.swift
//  yuna_test
//
//  Created by user12 on 2023/12/13.

import Foundation
import SwiftUI
import Combine

class GetSpotifyTrackData: ObservableObject {
    
    @Published var data = [spotifyTrackData]()
    @Published var searchQuery = "haikyuu" // Default search query
    
    init() {
        let parameters = "grant_type=refresh_token&refresh_token=AQBPjMWchUfc8SzJhpSoRihHL3wQmkUU8AY4JKZtxPTG_OZSOAYg-TlqP5e3atoypArNqCVtpX8GL9ydAQpdEFKgORyqhiDb8DYf3Z8ZSeQh-s3m6RoNdkCyWtT534jB6hA"
        let postData = parameters.data(using: .utf8)

        var request = URLRequest(url: URL(string: "https://accounts.spotify.com/api/token")!,timeoutInterval: Double.infinity)
        request.addValue("application/x-www-form-urlencoded", forHTTPHeaderField: "Content-Type")
        request.addValue("Basic NDI1ZGVjYjIwNzA2NGMwNmI4ZjMxNDQ3YmE3M2Q1MWY6NTJmZDgxM2Y5MDQ0NGExYmE3ZGIwODE5MDA5NWFmOTU=", forHTTPHeaderField: "Authorization")
        request.addValue("__Host-device_id=AQDmpKOIijZkJf7GiN-gQBqxA3jy6EfC8ID4RnXCYqGvurzyirDJIrdpYr2fKdAU0PegyaqZVb4lXPl7dASlyjj5n05EiN7fFy4; sp_tr=false", forHTTPHeaderField: "Cookie")

        request.httpMethod = "POST"
        request.httpBody = postData

        let session = URLSession(configuration: .default)
        session.dataTask(with: request) { (data, _, error) in
            guard let data = data, error == nil else {
                print("error!")
                print(error?.localizedDescription ?? "No data")
                return
            }

            do {
                let decoder = JSONDecoder()
                let tokenResponse = try decoder.decode(TokenResponse.self, from: data)
                let token = tokenResponse.access_token

                var trackRequest = URLRequest(url: URL(string: "https://api.spotify.com/v1/search?q=haikyuu&type=track")!, timeoutInterval: Double.infinity)
                trackRequest.addValue("Bearer \(token)", forHTTPHeaderField: "Authorization")
                trackRequest.httpMethod = "GET"
                trackRequest.httpBody = nil
                
                session.dataTask(with: trackRequest) { (trackData, _, trackError) in
                    guard let trackData = trackData, trackError == nil else {
                        print("error!!")
                        print(trackError?.localizedDescription ?? "No track data")
                        return
                    }

                    do {
                        let trackDecoder = JSONDecoder()
                        let trackResponse = try trackDecoder.decode(SpotifyTrackResponse.self, from: trackData)
                        let tracks = trackResponse.tracks.items

                        DispatchQueue.main.async {
                            self.data = tracks
                        }
                    } catch {
                        print("Error decoding JSON: \(error)")
                        print("Error decoding JSON:", String(data: trackData, encoding: .utf8) ?? "Unknown data")
                        print(error.localizedDescription)
                    }
                }.resume()

            } catch {
                print(error.localizedDescription)
            }
        }.resume()
    }
}
