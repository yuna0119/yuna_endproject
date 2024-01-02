//
//  Youtubeapi.swift
//  yuna_endproject
//
//  Created by user05 on 2023/12/13.
//
import SwiftUI

class YouTubeViewModel: ObservableObject {
    @Published var videos: [YouTubeItem] = []

    func fetchYouTubeVideos(videoIds: [String], apiKey: String) {
        let videoIdsString = videoIds.joined(separator: ",")
        let urlString = "https://www.googleapis.com/youtube/v3/videos?id=\(videoIdsString)&key=\(apiKey)&part=snippet"

        if let url = URL(string: urlString) {
            URLSession.shared.dataTask(with: url) { data, response, error in
                if let data = data {
                    do {
                        let decoder = JSONDecoder()
                        let result = try decoder.decode(YouTubeModel.self, from: data)
                        DispatchQueue.main.async {
                            self.videos = result.items
                        }
                    } catch {
                        print("Error decoding JSON:", error)
                    }
                }
            }.resume()
        }
    }
}
