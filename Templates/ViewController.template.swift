import RxSwift
import UIKit

final class {{ScreenName}}ViewController: BaseViewController {
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)

        navigationController?.setNavigationBarHidden(true, animated: false)
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        layout()
        bind()
    }
    
    override func viewDidAppear(_ animated: Bool) {
        super.viewDidAppear(animated)
    }
}

private extension {{ScreenName}}ViewController {
    func layout(){
        
    }
    
    func bind(){
        
    }
    
    func bindRx(){
        
    }
}
