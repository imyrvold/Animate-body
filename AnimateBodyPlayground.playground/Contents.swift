import UIKit
import PlaygroundSupport

class ViewController : UIViewController {
    
    lazy var bodyView: UIImageView = {
        let bodyView = UIImageView()
        bodyView.contentMode = .scaleAspectFill
        bodyView.image = self.image
        bodyView.backgroundColor = .yellow
        return bodyView
    }()
    lazy var image: UIImage? = {
        UIImage(named: "body")
    }()
    lazy var button: UIButton = {
        let button = UIButton(frame: CGRect(x: 0, y: 0, width: 100, height: 50))
        button.setTitle("Start", for: .normal)
        button.addTarget(self, action: #selector(headZoom), for: .touchDown)
        button.titleLabel?.textColor = .black
        button.backgroundColor = .lightGray
        return button
    }()
    lazy var circle: BodyAreaView = {
        let circle = BodyAreaView(frame: CGRect(x: 0, y: 0, width: 48, height: 48))
        circle.backgroundColor = .cyan
        
        return circle
    }()
    // bodyView constraints
    var topAnchorConstraint: NSLayoutConstraint!
    var centerXAnchorConstraint: NSLayoutConstraint!
    var aspectConstraint: NSLayoutConstraint!
    var superWidthConstraint: NSLayoutConstraint!
    var iphoneHeightConstraint: NSLayoutConstraint!
    var iphoneWidthConstraint: NSLayoutConstraint!
    
    // fibroLowerNeck constraints
    var circleHeightConstraint: NSLayoutConstraint!
    var circleXConstraint: NSLayoutConstraint!
    var circleYConstraint: NSLayoutConstraint!
    var circleAspectConstraint: NSLayoutConstraint!
    
    override func loadView() {
        let view = UIView()
        view.backgroundColor = .white
        self.view = view
        
        view.addSubview(self.bodyView)
        self.bodyView.addSubview(self.circle)
        view.addSubview(self.button)
        self.view.translatesAutoresizingMaskIntoConstraints = false
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
    }
    
    var didInitialLayout = false
    override func viewDidLayoutSubviews() {
        if didInitialLayout { return } // *
        didInitialLayout = true //
        self.setBodyViewConstraints()
        self.setFibroConstraints()
        
        self.bodyView.translatesAutoresizingMaskIntoConstraints = false
        self.circle.translatesAutoresizingMaskIntoConstraints = false
        NSLayoutConstraint.activate([
            self.topAnchorConstraint,
            self.centerXAnchorConstraint,
            self.aspectConstraint,
            self.iphoneWidthConstraint
            ])
        
        NSLayoutConstraint.activate([
            self.circleHeightConstraint,
            self.circleXConstraint,
            self.circleYConstraint,
            self.circleAspectConstraint
            ])
    }
    
    override func viewDidAppear(_ animated: Bool) {
        super.viewDidAppear(animated)
    }
    
    @objc func headZoom() {
        self.iphoneWidthConstraint.isActive = false // *
        self.superWidthConstraint.isActive = true
        print("body view before: \(self.bodyView.bounds)")
        print("circle origin before: \(self.circle.frame.origin)")
        UIView.animate(withDuration: 3, animations: {
            self.view.layoutIfNeeded()
        }) { _ in
            print("body view after: \(self.bodyView.bounds)")
            print("circle frame after: \(self.circle.frame)")
            self.view.setNeedsDisplay()
            self.circle.setNeedsDisplay()
        }
    }
    
    func setBodyViewConstraints() {
        self.topAnchorConstraint = self.bodyView.topAnchor.constraint(equalTo: self.view.topAnchor)
        self.centerXAnchorConstraint = self.bodyView.centerXAnchor.constraint(equalTo: self.view.centerXAnchor)
        self.aspectConstraint = self.bodyView.heightAnchor.constraint(equalTo: self.bodyView.widthAnchor, multiplier: 1388/408.0)
        self.superWidthConstraint = self.bodyView.widthAnchor.constraint(equalTo: self.view.widthAnchor, multiplier: 1)
        self.iphoneHeightConstraint = self.bodyView.heightAnchor.constraint(equalToConstant: 633)
        self.iphoneWidthConstraint = self.bodyView.widthAnchor.constraint(equalToConstant: 186)
    }
    
    func setFibroConstraints() {
        self.circleHeightConstraint = self.circle.heightAnchor.constraint(equalTo: self.bodyView.heightAnchor, multiplier: 0.05)
        self.circleXConstraint = NSLayoutConstraint(item: self.circle, attribute: .centerX, relatedBy: .equal, toItem: self.bodyView, attribute: .centerX, multiplier: 0.5, constant: 0)
        self.circleYConstraint = NSLayoutConstraint(item: self.circle, attribute: .centerY, relatedBy: .equal, toItem: self.bodyView, attribute: .centerY, multiplier: 0.5, constant: 0)
        self.circleAspectConstraint = self.circle.heightAnchor.constraint(equalTo: self.circle.widthAnchor, multiplier: 1)
    }
    
}

let viewController = ViewController()
viewController.preferredContentSize = CGSize(width: 375, height: 812)

PlaygroundPage.current.liveView = viewController

