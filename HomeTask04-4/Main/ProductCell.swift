import Foundation
import UIKit
import Kingfisher

protocol ProductAction: AnyObject {
    func favoriteTap(index: Int)
}


class ProductCell: UICollectionViewCell {
    
    static var reuseId = "product_cell"
    
    weak var delegate: ProductAction?
    
    var indexPath: IndexPath?
    
    private var titleLabel: UILabel = {
        let view = UILabel()
        view.font = .systemFont(ofSize: 16, weight: .bold)
        view.numberOfLines = 2
        return view
    }()
    
    private var priceLabel: UILabel = {
        let lb = UILabel()
        lb.font = .systemFont(ofSize: 12, weight: .semibold)
        lb.textColor = .blue
        return lb
    }()
    
    private var productImage: UIImageView = {
        let view = UIImageView()
        view.contentMode = .scaleAspectFit
        return view
    }()
    
    private lazy var favoriteImage: UIImageView = {
        let view = UIImageView()
        view.image = UIImage(systemName: "heart")
        view.isUserInteractionEnabled = true
        let tap = UITapGestureRecognizer(target: self, action: #selector(favoriteTapped))
        view.addGestureRecognizer(tap)
        return view
    }()
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        setupSubViews()
        layer.borderWidth = 0.5
        layer.borderColor = UIColor.black.cgColor
        layer.cornerRadius = 5
        backgroundColor = .white
    }
    
    @objc func favoriteTapped() {
        delegate?.favoriteTap(index: indexPath!.row)
    }
    
    func fillData(data: Product) {
        productImage.kf.setImage(with: URL(string: data.thumbnail))
        titleLabel.text = data.title
        priceLabel.text = "\(data.price) $"
    }
    
    func setupSubViews() {
        contentView.addSubview(productImage)
        contentView.addSubview(titleLabel)
        contentView.addSubview(priceLabel)
        contentView.addSubview(favoriteImage)
        
        productImage.snp.makeConstraints { make in
            make.left.right.equalToSuperview().inset(4)
            make.top.equalToSuperview()
            make.height.equalTo(200)
        }
        
        titleLabel.snp.makeConstraints { make in
            make.top.equalTo(productImage.snp.bottom).offset(4)
            make.left.equalToSuperview().offset(4)
            make.right.equalTo(favoriteImage.snp.left).offset(-8)
            make.height.equalTo(44)
            
        }
        
        priceLabel.snp.makeConstraints { make in
            make.top.equalTo(titleLabel.snp.bottom).offset(4)
            make.left.equalToSuperview().offset(4)
        }
        
        favoriteImage.snp.makeConstraints { make in
            make.top.equalTo(productImage.snp.bottom).offset(4)
            make.right.equalToSuperview().offset(-4)
            make.width.height.equalTo(20)
        }
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
}
