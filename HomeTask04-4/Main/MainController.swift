import Foundation

class MainController {
    
    private var view: ViewController
    private var model: MainModel?
    
    init(view: ViewController) {
        self.view = view
        self.model = MainModel(controller: self)
    }
    
    func fetchProduct() {
        model?.fetchProduct()
    }
    
    func reloadedCollectionView() {
        view.reloadCollectionView()
    }
    
    func getProduct() -> [Product] {
        let result = model?.getProduct()
        return result ?? []
    }
    
    func datatoSave(index: Int) {
        model?.saveProduct(by: index)
    }
}
