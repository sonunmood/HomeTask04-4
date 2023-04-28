import Foundation

class NetworkManager {
    
    let session = URLSession.shared
    
    func fetchProduct(completion: @escaping(ProductList) -> ()) {
        
        let url =  URL(string: "https://dummyjson.com/products")
        
        let request = URLRequest(url: url!)
        
        session.dataTask(with: request) { data, response, error in
            
            guard let data = data, error == nil else {
                return
            }
            
            let statusCode = response as! HTTPURLResponse
            
            do {
                let result = try JSONDecoder().decode(ProductList.self, from: data)
                print(result)
                completion(result)
                print(statusCode.statusCode)
            } catch {
                print(error)
            }
        }
        .resume()
    }
}
