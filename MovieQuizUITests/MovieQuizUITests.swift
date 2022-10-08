import XCTest

class MovieQuizUITests: XCTestCase {
    var app: XCUIApplication!
    
    
    override func setUpWithError() throws {
        app = XCUIApplication()
        app.launch()
        continueAfterFailure = false
    }
    
    override func tearDownWithError() throws {
        app.terminate()
        app = nil
    }
    
    func testYesButton() {
        let firstPoster = app.images["Poster"]
        app.buttons["Да"].tap()
        let secondPoster = app.images["Poster"]
        let indexLabel = app.staticTexts["Вопрос:"]
        sleep(3)
        XCTAssertTrue(indexLabel.label == "2/10")
        XCTAssertFalse(firstPoster == secondPoster)
    }
    
    func testNoButton() {
        let firstPoster = app.images["Poster"]
        app.buttons["Нет"].tap()
        let secondPoster = app.images["Poster"]
        let indexLabel = app.staticTexts["Вопрос:"]
        sleep(3)
        XCTAssertTrue(indexLabel.label == "2/10")
        XCTAssertFalse(firstPoster == secondPoster)
    }
    
    func testAlertExist() {
        sleep(4)
        for _ in 0..<10 {
            app.buttons["Да"].tap()
            sleep(2)
        }
        let indexLabel = app.staticTexts["Вопрос:"]
        XCTAssertTrue(indexLabel.label == "10/10")
        let resultAlert = app.alerts["result_alert"]
        XCTAssertTrue(resultAlert.exists)
        XCTAssertTrue(resultAlert.label == "Этот раунд окончен")
        XCTAssertTrue(resultAlert.buttons.firstMatch.label == "Сыграть еще раз")
    }
    
    func testAlertDisappear() {
        sleep(5)
        var i = 0
        while i < 10 {
            app.buttons["Да"].tap()
            sleep(5)
            i += 1
        }
        let indexLabel = app.staticTexts["Index"]
        XCTAssertTrue(indexLabel.label == "10/10")
        let resultAlert = app.alerts["result_alert"]
        XCTAssertTrue(resultAlert.exists)
        XCTAssertTrue(resultAlert.label == "Этот раунд окончен")
        XCTAssertTrue(resultAlert.buttons.firstMatch.label == "Сыграть еще раз")
        resultAlert.buttons.firstMatch.tap()
        sleep(4)
        XCTAssertTrue(indexLabel.label == "1/10")
        XCTAssertFalse(resultAlert.exists)
    }
}
