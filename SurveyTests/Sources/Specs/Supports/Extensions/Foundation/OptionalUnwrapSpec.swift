import Nimble
import Quick

import Accessibility
@testable import Survey

final class OptionalUnwrapSpec: QuickSpec {

    override func spec() {

        describe("an string optional") {
            var value: String?

            context("when value is not nil") {
                beforeEach {
                    value = "hello world"
                }

                it("returns string with unwrap value") {
                    expect(value) == "hello world"
                }
            }

            context("when value is nil") {
                beforeEach {
                    value = nil
                }

                it("returns nil") {
                    expect(value).to(beNil())
                }
            }
        }
    }
}
