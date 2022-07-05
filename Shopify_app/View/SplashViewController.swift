import UIKit
import Lottie

class SplashViewController: UIViewController {
    let animationView = AnimationView()
    static let animation = "loadingspinner"
    override func viewDidLoad() {
        super.viewDidLoad()
        startAnimation()
        handleAuthenticationNavigation()
    }
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        navigationController?.isNavigationBarHidden = true
    }
    private func startAnimation () {
        animationView.animation = Animation.named(SplashViewController.animation)
        animationView.frame = CGRect(x: 0, y: 0, width: 150, height: 150)
        animationView.center = view.center
        animationView.contentMode = .scaleAspectFit
        animationView.loopMode = .loop
        animationView.play()
        view.addSubview(animationView)
    }
    func handleAuthenticationNavigation() {
        let accessID = ApplicationUserManger.shared.getUserID()
        DispatchQueue.main.asyncAfter(deadline: .now() + 2) {
            if accessID != 0 {
                let vc = UIStoryboard(name: "Main", bundle: nil).instantiateViewController(withIdentifier: "TabBarViewController") as! TabBarViewController
                let nav = UINavigationController(rootViewController: vc)
                nav.modalPresentationStyle = .fullScreen
                self.present(nav, animated: true, completion: nil)
            } else {
                let vc = UIStoryboard(name: "Authentication", bundle: nil).instantiateViewController(withIdentifier: "LoginViewController") as! LoginViewController
                let nav = UINavigationController(rootViewController: vc)
                nav.modalPresentationStyle = .fullScreen
                self.present(nav, animated: true, completion: nil)
            }
        }
    }
}
