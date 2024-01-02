import Foundation

struct YouTubeModel: Codable {
    let items: [YouTubeItem]
}

struct YouTubeItem: Codable, Identifiable {
    let id: String
    let snippet: YouTubeSnippet
}

struct YouTubeSnippet: Codable {
    let title: String
    let description: String
    let thumbnails: YouTubeThumbnails
}

struct YouTubeThumbnails: Codable {
    let medium: YouTubeThumbnail
}

struct YouTubeThumbnail: Codable {
    let url: String
}
