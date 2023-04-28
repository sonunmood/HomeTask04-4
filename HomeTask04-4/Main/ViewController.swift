import UIKit
import SnapKit

class ViewController: UIViewController {
    
    private var controller: MainController?
    
    var filteredProduct : [Product] = []
    
    var isFiltered = true
    
    private lazy var searchTextField: UITextField = {
        let view = UITextField()
        view.placeholder = "Search"
        view.addTarget(self, action: #selector(editingChanged), for: .editingChanged)
        return view
    }()
    
    private lazy var collectionView: UICollectionView = {
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
      controller = MainController(view: self)
        setupSubViews()
        controller?.fetchProduct()
    }
    
    @objc func editingChanged() {
        if searchTextField.text != "" {
            filteredProduct = controller?.getProduct().filter({ $0.title.lowercased().contains(searchTextField.text?.lowercased() ?? "") }) ?? []
        } else {
            filteredProduct = []
        }
            reloadCollectionView()
    }
    
    func reloadCollectionView() {
        DispatchQueue.main.async {
            self.collectionView.reloadData()
        }
    }
    
    private func setupSubViews() {

        view.addSubview(searchTextField)
        searchTextField.snp.makeConstraints { make in
            make.top.equalTo(view.safeAreaLayoutGuide.snp.top)
            make.left.equalToSuperview().offset(24)
            make.right.equalToSuperview().offset(-24)
            make.height.equalTo(44)
        }

        view.addSubview(collectionView)
        collectionView.snp.makeConstraints { make in
            make.top.equalTo(searchTextField.snp.bottom).offset(12)
            make.right.left.equalToSuperview()
            make.bottom.equalToSuperview().offset(-12)
        }
    }
}

extension ViewController: UICollectionViewDataSource {
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        if !filteredProduct.isEmpty {
            return filteredProduct.count
        } else {
            return controller?.getProduct().count ?? 0
        }
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        let cell = collectionView.dequeueReusableCell(withReuseIdentifier: ProductCell.reuseId, for: indexPath) as! ProductCell
        guard let product = controller?.getProduct()[indexPath.row]  else { return UICollectionViewCell()
        }
        cell.indexPath = indexPath
        cell.delegate = self
        if !filteredProduct.isEmpty {
            cell.fillData(data: filteredProduct[indexPath.row])
        } else {
            cell.fillData(data: product)
        }
        
        return cell
    }
}

extension ViewController: UICollectionViewDelegateFlowLayout {
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAt indexPath: IndexPath) -> CGSize {
        return CGSize(width: (view.bounds.width - 24) / 2,
                      height: 290)
    }
}

extension ViewController: ProductAction {
    func favoriteTap(index: Int) {
        // call functions to send datas to controller then to model
        controller?.datatoSave(index: index)
    }
    
    
}
