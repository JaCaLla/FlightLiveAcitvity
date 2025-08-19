import SwiftUI
import ActivityKit
import UserNotifications
import os.log
import LiveActivityData

// MARK: - View

struct BookingBoardView: View {
    @StateObject private var controller = BookingBoardViewModel()

    var body: some View {
        VStack(alignment: .center, spacing: 24) {
            VStack(alignment: .center, spacing: 16) {
                Text("Activity Operations").font(.headline)

                if let id = controller.currentActivity?.id {
                    Text("Current Activity: \(id)")
                        .font(.caption)
                        .foregroundStyle(.secondary)
                }

                VStack {
                    Button("Create booking") {
                        controller.startActivity(initialState: .booking)
                    }

                    Group {
                        Button("30% seats free") {
                            controller.updateActivity(newState: .booking30Free)
                        }
                        Button("Checkin available") {
                            controller.updateActivity(newState: .checkinAvailable)
                        }
                        Button("Boarding") {
                            controller.updateActivity(newState: .boarding)
                        }
                        Button("Landed") {
                            controller.updateActivity(newState: .landed)
                        }
                        Button("End", role: .destructive) {
                            controller.finishActivity()
                        }
                    }
                    .disabled(controller.currentActivity == nil)
                }
                .buttonStyle(.borderedProminent)
            }

            VStack(alignment: .leading, spacing: 8) {
                HStack {
                    Text("Activity List").font(.headline)
                    Spacer()
                    Button("Refresh") { controller.refreshActivities() }
                }

                if controller.activities.isEmpty {
                    Text("No activities").foregroundStyle(.secondary)
                } else {
                    ForEach(controller.activities, id: \.id) { act in
                        Text("• \(act.id)")
                            .font(.caption)
                            .foregroundStyle(.secondary)
                            .textSelection(.enabled)
                    }
                }
            }

            Spacer()
        }
        .frame(maxWidth: .infinity, alignment: .leading)
        .padding()
        .navigationTitle("Live Activity Demo")
        .task {
            await controller.requestNotificationPermissions()
            controller.refreshActivities()
        }
    }
}
