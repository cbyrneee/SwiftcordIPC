import XCTest
@testable import SwiftcordIPC

final class SwiftcordIPCTests: XCTestCase {
    func testExample() throws {
        let ipc = SwiftcordIPC(id: "937029972139327558")
        ipc.onReady = { data in
            print("Ready! User: \(data.user.username)#\(data.user.discriminator)")
                        
            ipc.setPresence { data in
                data.details = "hello"
                data.state = "world"
                data.assets = assets(largeImage: "hello", largeImageText: "world")
                data.buttons = [
                    button(label: "click me!", url: "https://cbyrne.dev")
                ]
            }
        }
        
        try ipc.connectAndBlock()
    }
}
