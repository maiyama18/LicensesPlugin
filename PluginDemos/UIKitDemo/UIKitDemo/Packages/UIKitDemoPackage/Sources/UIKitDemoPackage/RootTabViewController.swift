import UIKit

public final class RootTabViewController: UITabBarController {
    public init() {
        super.init(nibName: nil, bundle: nil)
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    public override func viewDidLoad() {
        super.viewDidLoad()
        
        setupTabs()
    }
    
    func setupTabs() {
        let mainViewController = UINavigationController(rootViewController: MainViewController())
        mainViewController.tabBarItem = .init(title: "Main", image: .init(systemName: "star"), tag: 0)
        
        let settingsViewController = UINavigationController(rootViewController: SettingsViewController())
        settingsViewController.tabBarItem = .init(title: "Settings", image: .init(systemName: "gearshape"), tag: 1)

        viewControllers = [mainViewController, settingsViewController]
    }
}
