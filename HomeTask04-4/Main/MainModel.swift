import Foundation

struct ProductList: Codable {
    var products: [Product]
}

struct Product: Codable {
    var id: Int
    var title: String
    var description: String
    var price: Int
    var thumbnail: String
}

class MainModel {
    
    private var networkManager = NetworkManager()
    
    private var products: [Product] = []
    
    private var filteredProduct: [Product] = []
    
    private var userDefaults = UserDefaults.standard
    
    private var savedProducts: [Product] = []
    
    private var controller: MainController
    
    init(controller: MainController) {
        self.controller = controller
    }
    
    func fetchProduct() -> () {
        networkManager.fetchProduct { [weak self] result in
            guard let self = self else { return }
            self.products = result.products
            self.controller.reloadedCollectionView()
        }
    }
    
    func getProduct() -> [Product] {
        return products
    }
    
//    func filterProduct() {
//        let searchProduct = products
//        filteredProduct.append(searchProduct)
//    }
    
    func saveProduct(by index: Int) {
        let product = products[index]
        savedProducts.append(product)
        
        let encodedProducts = try? JSONEncoder().encode(savedProducts)
        
        userDefaults.set(encodedProducts, forKey: "favorites")
    }
}
