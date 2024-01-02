//
//  SpotifyData.swift
//  yuna_test
//
//  Created by user12 on 2023/12/13.
//

import Foundation

struct TokenResponse: Decodable {
    var access_token: String
}

struct SpotifyTrackResponse: Decodable {
    var tracks: Tracks
}

struct Tracks: Decodable {
    var items: [spotifyTrackData]
}

struct spotifyTrackData: Decodable, Identifiable {
    var id: String
    var name: String
    var artists: [Artist]
    var imgurl: String
    var external_urls: ExternalURLs
    var album: Album

    enum CodingKeys: String, CodingKey {
        case id
        case name
        case artists
        case external_urls
        case album
    }

    init(from decoder: Decoder) throws {
        let container = try decoder.container(keyedBy: CodingKeys.self)
        id = try container.decode(String.self, forKey: .id)
        name = try container.decode(String.self, forKey: .name)
        artists = try container.decode([Artist].self, forKey: .artists)
        external_urls = try container.decode(ExternalURLs.self, forKey: .external_urls)
        album = try container.decode(Album.self, forKey: .album)

        // Attempt to decode "images" within "album"
        if let firstImage = album.images.first {
            imgurl = firstImage.url
        } else {
            // Set default empty string if "images" is empty
            imgurl = ""
        }
    }
}



struct ExternalURLs: Decodable {
    var spotify: String
}

struct Album: Decodable {
    var images: [ImageData]
}

struct ImageData: Decodable {
    let height: Int
    let url: String
    let width: Int
}

struct Artist: Decodable {
    var external_urls: ExternalURL
    var href: String
    var id: String
    var name: String
    var type: String
    var uri: String
}

struct ExternalURL: Decodable {
    var spotify: String
}
