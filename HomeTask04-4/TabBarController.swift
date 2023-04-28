import Foundation
import UIKit

class TabBarController: UITabBarController {
    
    override func viewDidLoad() {
        super.viewDidLoad()
        setUpChildViewController()
        self.tabBar.backgroundColor = .systemBackground
    }
    
    func setUpChildViewController() {
        let viewController = ViewController()
        let favoriteVC = FavoriteViewController()
        
        let viewControllerImage = UIImage(systemName: "house")
        let favoriteVCImage = UIImage(systemName: "heart")
        
        viewControllers = [generateNavigationController(rootViewController: viewController, image: viewControllerImage!),generateNavigationController(rootViewController: favoriteVC, image: favoriteVCImage!)]
        
    }
    
    
    func generateNavigationController(rootViewController: UIViewController, image: UIImage) -> UIViewController {
        let navigationController = UINavigationController(rootViewController: rootViewController)
        navigationController.tabBarItem.image = image
        return navigationController
    }
    
    
    
}
