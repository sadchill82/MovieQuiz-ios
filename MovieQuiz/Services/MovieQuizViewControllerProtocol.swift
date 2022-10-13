import UIKit

protocol MovieQuizViewControllerProtocol: UIViewController {
    func showLoadingIndicator()
    func hideLoadingIndicator()
    func highlightImageBorder(isCorrect: Bool)
    func hideImageBorder()
    func showStep(quize step: QuizStepViewModel)
}
