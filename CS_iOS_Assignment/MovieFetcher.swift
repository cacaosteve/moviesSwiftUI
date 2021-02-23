import SwiftUI
import Alamofire
import Combine

struct ResponseData : Decodable {
    var results: [Movie]
}

public class MovieFetcher: ObservableObject {
    @Published var searchText = ""
    
    var publisher: AnyCancellable?
    
    @Published var movies = [Movie]() {
        willSet {
            self.objectWillChange.send()
        }
    }
    
    var filteredData: [Movie] = [Movie]()
    
    @Published var showFavoritesOnly = false
    @Published var error = false
    @Published var isLoadingPage = false
    private var currentPage = 1
    private var canLoadMorePages = true
    
    public init(){
        self.publisher = $searchText
            .receive(on: RunLoop.main)
            .sink(receiveValue: { (str) in
                if !self.searchText.isEmpty {
                    self.filteredData = self.movies
                        .filter { $0.title!.contains(str) }
                } else {
                    self.filteredData = self.movies
                }
            })
        
        loadFromDisk()
        if movies.count == 0 {
            loadWithAF()
        }
    }
    func update(movie: () -> Movie) {
        if
            let index = self.movies.firstIndex(where: {
                $0.id == movie().id
                
            }) {
            self.movies[index] = movie()
            let copy = self.movies
            self.movies = copy
            self.filteredData = self.movies
            self.saveToDisk()
        }
    }
    func loadMoreContentIfNeeded(currentItem movie: Movie?) {
        guard let movie = movie else {
            loadWithAF()
            return
        }
        
        let thresholdIndex = movies.index(movies.endIndex, offsetBy: -5)
        if movies.firstIndex(where: { $0.id == movie.id }) == thresholdIndex {
            loadWithAF()
        }
    }
    func loadWithAF() {
        guard !isLoadingPage && canLoadMorePages else {
            return
        }
        isLoadingPage = true
        
        let decoder: JSONDecoder = {
            let decoder = JSONDecoder()
            decoder.keyDecodingStrategy = .convertFromSnakeCase
            return decoder
        }()
        
        let request = AF.request("https://api.themoviedb.org/3/movie/now_playing?api_key=78b4a0dda1dd9edb77aad31bb45879d6&page=\(currentPage)")
        request.responseDecodable(of: ResponseData.self, decoder: decoder) { (response) in
            //self.canLoadMorePages = response.hasMorePages
            self.isLoadingPage = false
            self.currentPage += 1
            
            switch response.result {
            case .success(let value):
                print(value)
                self.movies += value.results
                self.filteredData = self.movies
                self.saveToDisk()
            case .failure( _):
                self.error = true
                print(self.error)
            }
        }
    }
    func saveToDisk() {
        if let encodedData = try? JSONEncoder().encode(self.movies) {
            let cachesDirectory = FileManager.default.urls(for: .cachesDirectory, in: .userDomainMask).first!
            let path = cachesDirectory.appendingPathComponent("movies.json")
            do {
                try encodedData.write(to: path)
            }
            catch {
                print("Failed to write JSON data: \(error.localizedDescription)")
            }
        }
    }
    func loadFromDisk() {
        let cachesDirectory = FileManager.default.urls(for: .cachesDirectory, in: .userDomainMask).first!
        let path = cachesDirectory.appendingPathComponent("movies.json")
        
        do {
            let data = try Data(contentsOf: path)
            let decoder = JSONDecoder()
            self.movies = try decoder.decode([Movie].self, from: data)
            self.filteredData = self.movies
        }
        catch {
            print("Failed to read JSON data: \(error.localizedDescription)")
        }
    }
}

struct MovieFetcher_Previews: PreviewProvider {
    static var previews: some View {
        /*@START_MENU_TOKEN@*/Text("Hello, World!")/*@END_MENU_TOKEN@*/
    }
}
