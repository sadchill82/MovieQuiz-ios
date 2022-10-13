import UIKit

class ResultAlertPresenter: ResultAlertPresenterProtocol {
    var title: String
    var text: String
    var buttonText: String
    var controller: UIViewController
    var accessibilityIdentifier: String

    init(title: String, text: String, buttonText: String, controller: UIViewController) {
        self.title = title
        self.text = text
        self.buttonText = buttonText
        self.controller = controller
        self.accessibilityIdentifier = "result_alert"
    }

    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }

    func showAlert(callback: @escaping () -> Void) {
        let alert = UIAlertController(
            title: self.title,
            message: self.text,
            preferredStyle: .alert
        )
        alert.view.accessibilityIdentifier = "result_alert"
        let action = UIAlertAction(
            title: self.buttonText,
            style: .default, handler: {_ in
                callback()
            })
        alert.addAction(action)

        controller.present(alert, animated: true, completion: nil)
    }
}
