import UIKit
import os.log
import UserNotifications

// MARK: - AppDelegate

final class AppDelegate: NSObject, UIApplicationDelegate {

    private let pushManager = PushNotificationManager()
    private let activityBootstrapper = ActivityBootstrapper()

    func application(
        _ application: UIApplication,
        didFinishLaunchingWithOptions launchOptions: [UIApplication.LaunchOptionsKey: Any]? = nil
    ) -> Bool {

        activityBootstrapper.start()
        pushManager.registerForRemoteNotifications(application)

        return true
    }

    func application(
        _ application: UIApplication,
        didRegisterForRemoteNotificationsWithDeviceToken deviceToken: Data
    ) {
        pushManager.handleSuccessfulRegistration(deviceToken: deviceToken)
    }

    func application(
        _ application: UIApplication,
        didFailToRegisterForRemoteNotificationsWithError error: Error
    ) {
        pushManager.handleFailedRegistration(error: error)
    }
}

// MARK: - PushNotificationManager

private final class PushNotificationManager {

    private let logger = Logger(subsystem: Bundle.main.bundleIdentifier ?? "App", category: "Push")

    func registerForRemoteNotifications(_ application: UIApplication) {

        UNUserNotificationCenter.current().requestAuthorization(options: [.alert, .badge, .sound]) { [weak self] granted, error in
            if let error {
                self?.logger.error("Notification authorization error: \(error.localizedDescription, privacy: .public)")
            } else {
                self?.logger.log("Notification authorization granted: \(granted, privacy: .public)")
            }

            DispatchQueue.main.async {
                application.registerForRemoteNotifications()
            }
        }
    }

    func handleSuccessfulRegistration(deviceToken: Data) {
        let token = deviceToken.hexEncodedString()
        logger.log("APNs device token: \(token, privacy: .private)")
    }

    func handleFailedRegistration(error: Error) {
        logger.error("Failed to register for remote notifications: \(error.localizedDescription, privacy: .public)")
    }
}

// MARK: - Activity bootstrap (agrupa listeners)

private struct ActivityBootstrapper {
    @MainActor func start() {
        BookingBoardViewModel.listenForTokenToStartActivityViaPush()
        BookingBoardViewModel.listenForTokenToUpdateActivityViaPush()
    }
}

// MARK: - Helpers

private extension Data {
    /// Hex en mayúsculas sin espacios.
    func hexEncodedString() -> String {
        map { String(format: "%02X", $0) }.joined()
    }
}
