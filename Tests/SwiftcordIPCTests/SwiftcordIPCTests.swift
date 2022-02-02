import XCTest
@testable import SwiftcordIPC

final class SwiftcordIPCTests: XCTestCase {
    func testExample() throws {
        let ipc = SwiftcordIPC(id: "937029972139327558")
        ipc.onReady = { data in
            print("Ready! User: \(data.user.username)#\(data.user.discriminator)")
            ipc.setPresence(details: "Hello", state: "World", largeImage: "myImage", largeImageText: "o/", buttonText: "Click me!", buttonUrl: "https://cbyrne.dev")
        }
        
        try ipc.connectAndBlock()
    }
}
