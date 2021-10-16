//
//  NetworkService.swift
//  Seehyang-iOS
//
//  Created by Jinha Park on 2021/10/16.
//

import Foundation
import Moya

enum NetworkService {
    case perfumeDetail(perfumeID: Int)
}

extension NetworkService: TargetType {
    var baseURL: URL { return URL(string: "http://seehyang-env.eba-sxhpxp66.ap-northeast-2.elasticbeanstalk.com/")! }

    var path: String {
        switch self {
        case .perfumeDetail(let perfumeID):
            return "api/v1/perfume/\(perfumeID)"
        }
    }
    
    var method: Moya.Method {
        switch self {
        case .perfumeDetail:
            return .get
        }
    }
    
    var task: Task {
        switch self {
        case .perfumeDetail:
            return .requestPlain
        }
    }
    
    var headers: [String: String]? {
        var headers: [String: String] = [:]
        headers["authorization"] = ""
        
        return headers
    }
    
    var validationType: ValidationType {
        return .successCodes
    }
}
