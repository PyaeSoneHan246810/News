//
//  ArticlesServiceImpl.swift
//  NewsApp
//
//  Created by Dylan on 31/12/2024.
//

import Foundation

class ArticlesServiceImpl: ArticlesService {
    
    func getTopHeadlineArticlesByCategory(category: String) async throws -> [ArticleDto] {
        let urlString = Constants.baseURL + Endpoint.topHeadlinesArticles(category: category).path + "&apiKey=\(Constants.apiKey)"
        guard let url = URL(string: urlString) else {
            throw NetworkingError.invalidURL
        }
        var urlRequest = URLRequest(url: url)
        urlRequest.httpMethod = HTTPMethod.get.rawValue
        urlRequest.setValue("application/json", forHTTPHeaderField: "Content-Type")
        let (data, urlResponse) = try await URLSession.shared.data(for: urlRequest)
        guard let httpUrlResponse = urlResponse as? HTTPURLResponse, httpUrlResponse.statusCode == 200 else {
            throw NetworkingError.badResponse
        }
        let decoder = JSONDecoder()
        guard let response = try? decoder.decode(ResponseDto.self, from: data) else {
            throw NetworkingError.decodingError
        }
        let articleDtos = response.articles.filter { article in
            article.urlToImage != nil && !article.urlToImage!.isEmpty
        }
        return articleDtos
    }
    
    func getRecommendedArticles(recommendation: String) async throws -> [ArticleDto] {
        let urlString = Constants.baseURL + Endpoint.recommendedArticles(query: recommendation).path + "&apiKey=\(Constants.apiKey)"
        guard let url = URL(string: urlString) else {
            throw NetworkingError.invalidURL
        }
        var urlRequest = URLRequest(url: url)
        urlRequest.httpMethod = HTTPMethod.get.rawValue
        urlRequest.setValue("application/json", forHTTPHeaderField: "Content-Type")
        let (data, urlResponse) = try await URLSession.shared.data(for: urlRequest)
        guard let httpUrlResponse = urlResponse as? HTTPURLResponse, httpUrlResponse.statusCode == 200 else {
            throw NetworkingError.badResponse
        }
        let decoder = JSONDecoder()
        guard let response = try? decoder.decode(ResponseDto.self, from: data) else {
            throw NetworkingError.decodingError
        }
        let articleDtos = response.articles.filter { article in
            article.urlToImage != nil && !article.urlToImage!.isEmpty
        }
        return articleDtos
    }
    
    func getCategoryArticles(category: String, page: Int) async throws -> ResponseDto {
        let urlString = Constants.baseURL + Endpoint.categoryArticles(category: category, page: page).path + "&apiKey=\(Constants.apiKey)"
        guard let url = URL(string: urlString) else {
            throw NetworkingError.invalidURL
        }
        var urlRequest = URLRequest(url: url)
        urlRequest.httpMethod = HTTPMethod.get.rawValue
        urlRequest.setValue("application/json", forHTTPHeaderField: "Content-Type")
        let (data, urlResponse) = try await URLSession.shared.data(for: urlRequest)
        guard let httpUrlResponse = urlResponse as? HTTPURLResponse, httpUrlResponse.statusCode == 200 else {
            throw NetworkingError.badResponse
        }
        let decoder = JSONDecoder()
        guard let response = try? decoder.decode(ResponseDto.self, from: data) else {
            throw NetworkingError.decodingError
        }
        return response
    }
    
    func searchArticles(query: String, page: Int) async throws -> ResponseDto {
        let urlString = Constants.baseURL + Endpoint.searchArticles(query: query, page: page).path + "&apiKey=\(Constants.apiKey)"
        guard let url = URL(string: urlString) else {
            throw NetworkingError.invalidURL
        }
        var urlRequest = URLRequest(url: url)
        urlRequest.httpMethod = HTTPMethod.get.rawValue
        urlRequest.setValue("application/json", forHTTPHeaderField: "Content-Type")
        let (data, urlResponse) = try await URLSession.shared.data(for: urlRequest)
        guard let httpUrlResponse = urlResponse as? HTTPURLResponse, httpUrlResponse.statusCode == 200 else {
            throw NetworkingError.badResponse
        }
        let decoder = JSONDecoder()
        guard let response = try? decoder.decode(ResponseDto.self, from: data) else {
            throw NetworkingError.decodingError
        }
        return response
    }
}
