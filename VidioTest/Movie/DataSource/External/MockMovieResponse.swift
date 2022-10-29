//
//  MockMovieResponse.swift
//  VidioTest
//
//  Created by Muhammad Azmi Khairullah on 29/10/22.
//

import Foundation

struct MockMovieResponse {
    static let mock: String = """
    [
        {
            "id": 1,
            "variant": "portrait",
            "items": [
            {
            "id": 1,
            "title": "title 1",
            "video_url": "https://vidio.com/watch/32442.m3u8",
            "image_url": "https://image.shutterstock.com/image-illustration/movie-super-premier-red-square-600w-1916053018.jpg"
            },
            {
            "id": 2,
            "title": "title 2",
            "video_url": "https://vidio.com/watch/32443.m3u8",
            "image_url": "https://image.shutterstock.com/image-vector/clapboard-popcorn-tickets-movie-making-600w-1714956634.jpg"
            }
            ]
        },
        {
            "id": 2,
            "variant": "landscape",
            "items": [
            {
            "id": 1,
            "title": "title 1",
            "video_url": "https://vidio.com/watch/32442.m3u8",
            "image_url": "https://image.shutterstock.com/image-vector/movie-film-banner-design-template-600w-557534047.jpg"
            },
            {
            "id": 2,
            "title": "title 2",
            "video_url": "https://vidio.com/watch/32443.m3u8",
            "image_url": "https://image.shutterstock.com/image-vector/movie-film-banner-design-template-600w-1056045455.jpg"
            }
            ]
        }
    ]
    """
}
