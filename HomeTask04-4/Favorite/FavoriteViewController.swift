import Foundation
import UIKit

class FavoriteViewController: UIViewController {
    
    private let userDefaults = UserDefaults.standard
    
    private var products: [Product] = []
    
    private lazy var favoriteCollectionView: UICollectionView = {
        let layout = UICollectionViewFlowLayout()
        layout.scrollDirection = .vertical
        layout.minimumLineSpacing = 8
        layout.minimumInteritemSpacing = 0
        let cv = UICollectionView(frame: .zero, collectionViewLayout: layout)
        cv.contentInset = UIEdgeInsets(top: 0, left: 8,
                                       bottom: 0, right: 8)
        cv.register(ProductCell.self, forCellWithReuseIdentifier: ProductCell.reuseId)
        cv.backgroundColor = .systemBackground
        cv.dataSource = self
        cv.delegate = self
        return cv
    }()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        setupSubviews()
        view.backgroundColor = .systemYellow
        if let favorites = userDefaults.object(forKey: "favorites") as? Data {
            let savedFavorites = try? JSONDecoder().decode([Product].self, from: favorites)
            products = savedFavorites!
        }
    }
    
    func setupSubviews() {
        view.addSubview(favoriteCollectionView)
        favoriteCollectionView.snp.makeConstraints { make in
            make.top.left.right.bottom.equalToSuperview()
        }
    }
}

extension FavoriteViewController: UICollectionViewDataSource {

    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        products.count
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        let cell = collectionView.dequeueReusableCell(withReuseIdentifier: ProductCell.reuseId, for: indexPath) as! ProductCell
        cell.indexPath = indexPath
//        cell.delegate = self
        cell.fillData(data:(products[indexPath.row]))
        return cell
    }
}

extension FavoriteViewController: UICollectionViewDelegateFlowLayout {
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAt indexPath: IndexPath) -> CGSize {
        return CGSize(width: (view.bounds.width - 24) / 2,
                      height: 290)
    }
}
