//
//  Copver.swift
//  yuna_endproject
//
//  Created by user05 on 2023/12/10.
//

import Foundation
import SwiftUI

struct Copver: View {
    @State private var selection = 0
    @ObservedObject var championData = character()
    var body: some View {
        TabView(selection: $selection){
            WebView()
                .tag(0)
                .tabItem {
                    Image(systemName: "globe")
                    Text("Website")
            }
            YouTubeView()
                .tag(2)
                .tabItem {
                    Image(systemName: "play.rectangle")
                    Text("Youtube")
            }
        
            
            SpotifyView()
            .tag(3)
                .tabItem {
                    Image(systemName: "music.note")
                        .padding()
                    Text("Spotify")
            }
            ChampionList(champsData: self.championData)
                .tag(4)
                .tabItem {
                    Image(systemName: "person.crop.rectangle.badge.plus")
                    Text("Character")
                }
            
        
        }
    }
}

struct Copver_Previews: PreviewProvider {
    static var previews: some View {
        Copver()
    }
}
