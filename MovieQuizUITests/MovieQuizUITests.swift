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
        XCTAssert(app.images["poster"].waitForExistence(timeout: 5))
        let firstPoster = app.images["poster"]
        let screenshotBefore = firstPoster.screenshot()
        app.buttons["Да"].tap()
        XCTAssert(app.staticTexts["2/10"].waitForExistence(timeout: 5))
        let secondPoster = app.images["poster"]
        let screenshotAfter = secondPoster.screenshot()
        XCTAssertNotEqual(screenshotBefore.pngRepresentation, screenshotAfter.pngRepresentation)
    }

    func testNoButton() {
        XCTAssert(app.images["poster"].waitForExistence(timeout: 5))
        let firstPoster = app.images["poster"]
        let screenshotBefore = firstPoster.screenshot()
        app.buttons["Нет"].tap()
        XCTAssert(app.staticTexts["2/10"].waitForExistence(timeout: 5))
        let secondPoster = app.images["poster"]
        let screenshotAfter = secondPoster.screenshot()
        XCTAssertNotEqual(screenshotBefore.pngRepresentation, screenshotAfter.pngRepresentation)
    }

    func testAlertExist() {
        XCTAssert(app.images["poster"].waitForExistence(timeout: 5))
        var i = 1
        while i < 10 {
            i += 1
            app.buttons["Да"].tap()
            XCTAssert(app.staticTexts["\(i)/10"].waitForExistence(timeout: 5))
        }
        app.buttons["Да"].tap()
        XCTAssert(app.staticTexts["10/10"].waitForExistence(timeout: 5))
        let resultAlert = app.alerts["result_alert"]
        XCTAssertTrue(resultAlert.exists)
        XCTAssertTrue(resultAlert.label == "Этот раунд окончен")
        XCTAssertTrue(resultAlert.buttons.firstMatch.label == "Сыграть еще раз")
    }

    func testAlertDisappear() {
        XCTAssert(app.images["poster"].waitForExistence(timeout: 5))
        var i = 1
        while i < 10 {
            i += 1
            app.buttons["Да"].tap()
            XCTAssert(app.staticTexts["\(i)/10"].waitForExistence(timeout: 5))
        }
        app.buttons["Да"].tap()
        XCTAssert(app.staticTexts["10/10"].waitForExistence(timeout: 5))
        let resultAlert = app.alerts["result_alert"]
        XCTAssertTrue(resultAlert.exists)
        XCTAssertTrue(resultAlert.label == "Этот раунд окончен")
        XCTAssertTrue(resultAlert.buttons.firstMatch.label == "Сыграть еще раз")
        resultAlert.buttons.firstMatch.tap()
        XCTAssert(app.images["poster"].waitForExistence(timeout: 5))
        XCTAssert(app.staticTexts["1/10"].waitForExistence(timeout: 5))
        XCTAssertFalse(resultAlert.exists)
    }
}
