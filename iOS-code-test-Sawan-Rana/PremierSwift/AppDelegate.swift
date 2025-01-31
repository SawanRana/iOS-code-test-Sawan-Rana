import UIKit

@UIApplicationMain
final class AppDelegate: UIResponder, UIApplicationDelegate {

    var window: UIWindow? = UIWindow()

    func application(_ application: UIApplication, didFinishLaunchingWithOptions launchOptions: [UIApplication.LaunchOptionsKey: Any]?) -> Bool {
        let viewModel = MoviesViewModel(apiManager: APIManager())
        let navigationController = UINavigationController(rootViewController: MoviesViewController(viewModel: viewModel))
        navigationController.view.backgroundColor = .white
        navigationController.navigationBar.prefersLargeTitles = true
        navigationController.navigationBar.barTintColor = .white
        navigationController.navigationBar.isTranslucent = false
        window!.rootViewController = navigationController
        window!.makeKeyAndVisible()
        return true
    }
}
