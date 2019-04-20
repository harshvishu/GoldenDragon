# GoldenDragon
iOS Networking Framework

![Image of Yaktocat](https://images.unsplash.com/photo-1514122769628-b4b8c3429ca5?ixlib=rb-1.2.1&ixid=eyJhcHBfaWQiOjEyMDd9&auto=format&fit=crop&w=1500&h=847&q=80)

### How to use?

- Extend `EndPointType` protocol
- Subclass `Router` in order to make the network calls 
- Use Codable protocols

```
enum Api {
    case search(query: String)
}

extension Api: EndPointType {
    
    public  var host: String {
        return "api.github.com"
    }
    
    public  var scheme: String {
        return "https"
    }
    
    public  var path: String {
        switch self {
        case .search:
            return "/search/repositories"
        }
    }
    
    public var httpMethod: HTTPMethod {
        switch self {
        case .search:
            return .get
        }
    }
    
    public var task: HTTPTask {
        switch self {
        case .search(let query):
            let params: Parameters = [
                "q": query
            ]
            return .requestParameters(bodyParameters: nil, bodyEncoding: .urlEncoding, urlParameters: params)
        }
    }
    
    public var headers: HTTPHeaders? {
        return nil
    }
}
```

```
 private var router: Router<Api> = Router<Api>()
 
 func testApi() {
        
        let expect: Future<SearchResult> = router.request(Api.search(query: "swift"))
        expect.observe { result in
            switch result {
            case .success(let searchData):
                print("\(searchData.totalCount) repositories found")
            case .failure(let error):
                print(error.localizedDescription)
            }
        }        
    }
```

```
 struct SearchResult: Codable {
        let totalCount: Int
        let items: [Item]
        
        enum CodingKeys: String, CodingKey {
            case totalCount = "total_count"
            case items
        }
    }
    
    struct Item: Codable {
        let id: Int
        let htmlURL: String
        let description: String
        
        enum CodingKeys: String, CodingKey {
            case id
            case htmlURL = "html_url"
            case description
        }
    }
