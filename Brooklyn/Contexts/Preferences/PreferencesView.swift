//
//  PreferencesView.swift
//  Brooklyn
//
//  Created for macOS Tahoe compatibility
//

import SwiftUI
import ScreenSaver

// MARK: - PreferencesView
struct PreferencesView: View {
    @StateObject private var viewModel = PreferencesViewModel()
    var onDismiss: (() -> Void)?

    var body: some View {
        VStack(spacing: 0) {
            headerView

            Divider()

            HStack(spacing: 0) {
                animationsList

                Divider()

                settingsPanel
            }

            Divider()

            footerView
        }
        .frame(width: 600, height: 500)
    }

    // MARK: - Header
    private var headerView: some View {
        HStack {
            Text("Brooklyn Preferences")
                .font(.headline)
            Spacer()
            Text("v\(viewModel.currentVersion)")
                .font(.caption)
                .foregroundColor(.secondary)
        }
        .padding()
    }

    // MARK: - Animations List
    private var animationsList: some View {
        VStack(alignment: .leading, spacing: 8) {
            Text("Animations")
                .font(.subheadline)
                .fontWeight(.medium)

            List(Animation.allCases, id: \.self) { animation in
                AnimationRowView(
                    animation: animation,
                    isSelected: viewModel.selectedAnimations.contains(animation),
                    onToggle: { viewModel.toggle(animation) }
                )
            }
            .listStyle(.plain)
        }
        .padding()
        .frame(width: 280)
    }

    // MARK: - Settings Panel
    private var settingsPanel: some View {
        VStack(alignment: .leading, spacing: 20) {
            VStack(alignment: .leading, spacing: 8) {
                Text("Settings")
                    .font(.subheadline)
                    .fontWeight(.medium)

                Toggle("Random order", isOn: $viewModel.hasRandomOrder)

                HStack {
                    Text("Loops per animation:")
                    Picker("", selection: $viewModel.numberOfLoops) {
                        ForEach(0..<31) { i in
                            Text(i == 0 ? "Infinite" : "\(i)").tag(i)
                        }
                    }
                    .frame(width: 100)
                }
            }

            Divider()

            VStack(alignment: .leading, spacing: 8) {
                Text("Selected: \(viewModel.selectedAnimations.count) animations")
                    .font(.caption)
                    .foregroundColor(.secondary)

                Button("Select All") {
                    viewModel.selectAll()
                }

                Button("Deselect All") {
                    viewModel.deselectAll()
                }
            }

            Spacer()

            VStack(alignment: .leading, spacing: 8) {
                Link("GitHub", destination: URL(string: "https://github.com/pedrommcarrasco/Brooklyn")!)
                Link("Report Issue", destination: URL(string: "https://github.com/pedrommcarrasco/Brooklyn/issues")!)
            }
            .font(.caption)
        }
        .padding()
        .frame(maxWidth: .infinity, alignment: .leading)
    }

    // MARK: - Footer
    private var footerView: some View {
        HStack {
            Spacer()
            Button("Done") {
                onDismiss?()
            }
            .keyboardShortcut(.defaultAction)
        }
        .padding()
    }
}

// MARK: - AnimationRowView
struct AnimationRowView: View {
    let animation: Animation
    let isSelected: Bool
    let onToggle: () -> Void

    var body: some View {
        HStack {
            Toggle(animation.name, isOn: Binding(
                get: { isSelected },
                set: { _ in onToggle() }
            ))
            Spacer()
        }
        .contentShape(Rectangle())
    }
}

// MARK: - PreferencesViewModel
@MainActor
final class PreferencesViewModel: ObservableObject {
    @Published var selectedAnimations: [Animation]
    @Published var numberOfLoops: Int {
        didSet { Database.standard.set(numberOfLoops: numberOfLoops) }
    }
    @Published var hasRandomOrder: Bool {
        didSet { Database.standard.set(hasRandomOrder: hasRandomOrder) }
    }

    let currentVersion: String

    init() {
        self.selectedAnimations = Database.standard.selectedAnimations
        self.numberOfLoops = Database.standard.numberOfLoops
        self.hasRandomOrder = Database.standard.hasRandomOrder

        if let bundle = Bundle(identifier: "oedrommcarrasco.brooklyn"),
           let version = bundle.infoDictionary?["CFBundleShortVersionString"] as? String {
            self.currentVersion = version
        } else {
            self.currentVersion = "3.0.0"
        }
    }

    func toggle(_ animation: Animation) {
        if selectedAnimations.contains(animation) {
            selectedAnimations.removeAll { $0 == animation }
            if selectedAnimations.isEmpty {
                selectedAnimations = [.original]
            }
        } else {
            selectedAnimations.append(animation)
        }
        Database.standard.set(animations: selectedAnimations)
    }

    func selectAll() {
        selectedAnimations = Animation.allCases
        Database.standard.set(animations: selectedAnimations)
    }

    func deselectAll() {
        selectedAnimations = [.original]
        Database.standard.set(animations: selectedAnimations)
    }
}

// MARK: - PreferencesHostingController
@MainActor
final class PreferencesHostingController: NSHostingController<PreferencesView> {

    convenience init() {
        self.init(onDismiss: nil)
    }

    init(onDismiss: (() -> Void)?) {
        let view = PreferencesView(onDismiss: onDismiss)
        super.init(rootView: view)
    }

    @MainActor required dynamic init?(coder: NSCoder) {
        super.init(coder: coder, rootView: PreferencesView())
    }

    override func viewDidLoad() {
        super.viewDidLoad()
        preferredContentSize = NSSize(width: 600, height: 500)
    }
}
