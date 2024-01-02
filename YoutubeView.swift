//
//  YoutubeView.swift
//  yuna_endproject
//
//  Created by user05 on 2023/12/13.
//

import SwiftUI

struct YouTubeView: View {
    @ObservedObject var viewModel = YouTubeViewModel()
    @State private var selectedVideoId: String?
    let apiKey = "AIzaSyChLvf9dYJ10CJEUa07eI7oioFiseLF1DY"  // Your YouTube Data API Key
    
    var body: some View {
        NavigationStack {
            ScrollView {
                VStack {
                    ForEach(viewModel.videos.prefix(4), id: \.id) { video in
                        VStack {
                            NavigationLink(
                                destination: SafariView(url: URL(string: "https://www.youtube.com/watch?v=\(video.id)")!),
                                isActive: Binding(
                                    get: { selectedVideoId == video.id },
                                    set: { _ in selectedVideoId = nil }
                                )
                            ) {
                                VStack(spacing: 10) {
                                    RemoteImage(url: video.snippet.thumbnails.medium.url)
                                        .aspectRatio(contentMode: .fit)
                                        .frame(height: 200)
                                    Text("\(video.snippet.title)")
                                        .font(.title3)
                                        .foregroundColor(.black)
                                }
                            }
                            .navigationTitle("排球少年影集").navigationBarTitleDisplayMode(.inline)
                        }
                        .padding(.vertical, 10) // 垂直方向的 padding

                        // 添加分隔线
                        if video.id != viewModel.videos.prefix(4).last?.id {
                            Divider()
                                .background(Color.gray)
                                .padding(.horizontal, 20)
                        }
                    }
                }
                .onAppear {
                    viewModel.fetchYouTubeVideos(videoIds: ["L6AHIUPlhsc", "ecc6gRrxRfo", "Mf6GjepHoX4", "GxM47k_IJNQ"], apiKey: apiKey)
                }
            }
        }
    }
}


struct RemoteImage: View {
    let url: String
    @State private var imageData: Data?

    var body: some View {
        if let data = imageData, let uiImage = UIImage(data: data) {
            Image(uiImage: uiImage)
                .resizable()
        } else {
            Image(systemName: "photo")
                .resizable()
                .onAppear {
                    downloadImage()
                }
        }
    }

    private func downloadImage() {
        guard let imageUrl = URL(string: url) else { return }

        URLSession.shared.dataTask(with: imageUrl) { (data, _, error) in
            if let error = error {
                print("Error downloading image: \(error)")
            } else if let data = data {
                DispatchQueue.main.async {
                    self.imageData = data
                }
            }
        }.resume()
    }
}

struct YouTubeView_Previews: PreviewProvider {
    static var previews: some View {
        YouTubeView()
    }
}
