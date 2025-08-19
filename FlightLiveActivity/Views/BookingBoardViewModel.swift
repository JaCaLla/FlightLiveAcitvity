import SwiftUI
import ActivityKit
import UserNotifications
import os.log
import LiveActivityData

@MainActor
final class BookingBoardViewModel: ObservableObject {
    @Published var currentActivity: Activity<FlightActivityAttributes>?
    @Published var activities: [Activity<FlightActivityAttributes>] = []

    private let logger = Logger(subsystem: Bundle.main.bundleIdentifier ?? "App", category: "LiveActivity")

    func refreshActivities() {
        activities = Activity<FlightActivityAttributes>.activities
        currentActivity = activities.first
    }

    func requestNotificationPermissions() async {
        do {
            let granted = try await UNUserNotificationCenter.current().requestAuthorization(options: [.alert, .badge, .sound])
            logger.log("Notification authorization granted: \(granted, privacy: .public)")
        } catch {
            logger.error("Error requesting notification authorization: \(error.localizedDescription, privacy: .public)")
        }
    }

    func startActivity(initialState: FlightActivityAttributes.ContentState) {
        let attrs = FlightActivityAttributes.bookingActivity
        let content = ActivityContent(state: initialState, staleDate: nil)

        do {
            currentActivity = try Activity.request(
                attributes: attrs,
                content: content,
                pushType: .token
            )
            refreshActivities()
        } catch {
            logger.error("Failed to start activity: \(error.localizedDescription, privacy: .public)")
        }
    }

    func updateActivity(newState: FlightActivityAttributes.ContentState) {
        guard let activity = currentActivity else { return }
        Task { @MainActor in
            let content = ActivityContent(state: newState, staleDate: nil)
            await activity.update(
                content,
                alertConfiguration: .init(
                    title: "New content!",
                    body: "New flight information!",
                    sound: .default
                )
            )
        }
    }

    func finishActivity() {
        guard let activity = currentActivity else { return }
        Task { @MainActor in
            await activity.end(
                ActivityContent(state: .landed, staleDate: nil),
                dismissalPolicy: .default
            )
            currentActivity = nil
            refreshActivities()
        }
    }

    // MARK: - Push token listeners (útiles si no los arrancas desde AppDelegate)

    static func listenForTokenToStartActivityViaPush() {
        Task {
            for await pushToken in Activity<FlightActivityAttributes>.pushToStartTokenUpdates {
                let token = pushToken.map { String(format: "%02x", $0) }.joined()
                Logger(subsystem: Bundle.main.bundleIdentifier ?? "App", category: "LiveActivity")
                    .log("[START] FlightActivityAttributes token: \(token, privacy: .private)")
            }
        }
    }

    static func listenForTokenToUpdateActivityViaPush() {
        Task {
            for await activity in Activity<FlightActivityAttributes>.activityUpdates {
                for await tokenData in activity.pushTokenUpdates {
                    let token = tokenData.map { String(format: "%02x", $0) }.joined()
                    Logger(subsystem: Bundle.main.bundleIdentifier ?? "App", category: "LiveActivity")
                        .log("[UPDATE] Activity \(activity.id) token: \(token, privacy: .private)")
                }

                for await state in activity.activityStateUpdates {
                    Logger(subsystem: Bundle.main.bundleIdentifier ?? "App", category: "LiveActivity")
                        .log("[STATE] Activity \(activity.id): \(String(describing: state), privacy: .public)")
                }

                for await content in activity.contentUpdates {
                    Logger(subsystem: Bundle.main.bundleIdentifier ?? "App", category: "LiveActivity")
                        .log("[CONTENT] Activity \(activity.id): \(String(describing: content), privacy: .public)")
                }
            }
        }
    }
}
