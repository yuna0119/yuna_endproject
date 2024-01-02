//
//  SpotifyView.swift
//  yuna_test
//
//  Created by user12 on 2023/12/13.
//

import SwiftUI
import Combine
import UIKit

struct SpotifyView: View {
    @ObservedObject var TopTracks = GetSpotifyTrackData()
    @State private var showSafariView = false
    @State private var safariViewURL = ""
    
    var body: some View {
        NavigationView {
            ScrollView(.vertical, showsIndicators: false) {
                ForEach(TopTracks.data) { track in
                    HStack(alignment: .top, spacing: 20) {
                        AsyncImage(url: URL(string: track.imgurl))
                            //.resizable() // Allow image to be resizable
                            //.scaledToFit() // Maintain aspect ratio while fitting within the frame
                            .frame(width: UIScreen.main.bounds.width/6, height: UIScreen.main.bounds.width/6)
                            .cornerRadius(10) // Optional: Add corner radius for a rounded look
                        
                        VStack(alignment: .leading, spacing: 5) {
                            Text("\(track.name)")
                                .foregroundColor(Color(.black))
                                .fontWeight(.bold)
                                .font(.system(size: 20))
                            Text(track.artists.map { $0.name }.joined(separator: ", "))
                                .foregroundColor(Color(.black))
                                .font(.system(size: 15))
                        }
                        
                        Spacer() // Add Spacer to push the button to the right
                        
                        NavigationLink(destination: safariViewURL.isEmpty ? nil : SafariView(url: URL(string: self.safariViewURL)!), isActive: $showSafariView) {
                            //EmptyView()
                            Button(action: {
                                self.safariViewURL = track.external_urls.spotify
                                self.showSafariView.toggle()
                            }) {
                                Image(systemName: "play.circle")
                                    .resizable()
                                    .scaledToFit()
                                    .frame(width: 30, height: 30) // Set a fixed size for the button
                            }
                        }
                        .navigationTitle("排球少年相關音樂").navigationBarTitleDisplayMode(.inline)
                    }
                    .padding(.horizontal) // Add horizontal padding for a cleaner look
                    .onAppear {
                        print("Image URL:", track.imgurl)
                    }
                }
            }
        }
    }
}



struct SpotifyView_Previews: PreviewProvider {
    static var previews: some View {
        SpotifyView()
    }
}
