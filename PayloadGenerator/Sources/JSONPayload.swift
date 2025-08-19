// The Swift Programming Language
// https://docs.swift.org/swift-book
//
// Swift Argument Parser
// https://swiftpackageindex.com/apple/swift-argument-parser/documentation

import ArgumentParser

@main
struct JSONPayload: ParsableCommand {
    @Argument(help: "Which step of the live activity cycle to generate as JSON")
    var step: Int

    @Flag(help: "Prints date in a human-readable style")
    var debug: Bool = false

    mutating func run() throws {
        let jsonString = switch step {
        case 1: try bookedFlight(debug: debug)
        case 2: try bookedFlight30Available(debug: debug)
        case 3: try checkinAvailable(debug: debug)
        case 4: try boarding(debug: debug)
        case 5: try landed(debug: debug)
        default:
            fatalError("No step '\(step)' defined")
        }
        print(jsonString)
    }
}
