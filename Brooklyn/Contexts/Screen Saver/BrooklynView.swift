//
//  BrooklynView.swift
//  Brooklyn
//
//  Created by Pedro Carrasco on 30/10/2018.
//  Copyright © 2018 Pedro Carrasco. All rights reserved.
//

import Foundation
import ScreenSaver
import AVKit
import SwiftUI

// MARK: - BrooklynView
final class BrooklynView: ScreenSaverView {

    // MARK: Local Typealias
    typealias Static = BrooklynView

    // MARK: Constant
    private enum Constant {
        static let secondPerFrame = 1.0 / 30.0
        static let backgroundColor = NSColor(red: 0.00, green: 0.01, blue: 0.00, alpha:1.0)
    }

    // MARK: Outlets
    private let videoLayer = AVPlayerLayer()

    // MARK: Properties
    private var manager: BrooklynManager
    private var preferencesWindow: NSWindow?

    // MARK: Initialization
    required init?(coder decoder: NSCoder) {
        self.manager = BrooklynManager(mode: .screensaver)
        super.init(coder: decoder)
        animationTimeInterval = Constant.secondPerFrame
        configure()
    }

    override init?(frame: NSRect, isPreview: Bool) {
        self.manager = BrooklynManager(mode: .screensaver)
        super.init(frame: frame, isPreview: isPreview)
        animationTimeInterval = Constant.secondPerFrame
        configure()
    }

    // MARK: Reload
    private func reloadPlayer() {
        manager.player.pause()
        manager = BrooklynManager(mode: .screensaver)
        videoLayer.player = manager.player
        manager.player.play()
    }
}

// MARK: - Lifecycle
extension BrooklynView {

    override func startAnimation() {
        super.startAnimation()
        manager.player.play()
    }

    override func stopAnimation() {
        super.stopAnimation()
        manager.player.pause()
    }

    override func layout() {
        super.layout()
        videoLayer.frame = bounds
    }
}

// MARK: - Configuration
private extension BrooklynView {
    
    func configure() {
        defineLayer()
        setupLayer()
    }
    
    func defineLayer() {
        wantsLayer = true
        defineVideoLayer()
        layer = videoLayer
    }
    
    func setupLayer() {
        videoLayer.player = manager.player
    }
}

// MARK: - Define Layers
private extension BrooklynView {

    func defineVideoLayer() {
        videoLayer.frame = bounds
        videoLayer.autoresizingMask = [.layerWidthSizable, .layerHeightSizable]
        videoLayer.needsDisplayOnBoundsChange = true
        videoLayer.contentsGravity = .resizeAspect
        videoLayer.backgroundColor = Constant.backgroundColor.cgColor
    }
}

// MARK: - Preferences
extension BrooklynView {

    override var hasConfigureSheet: Bool {
        return true
    }

    override var configureSheet: NSWindow? {
        if preferencesWindow == nil {
            let preferencesView = PreferencesView { [weak self] in
                guard let self = self, let window = self.preferencesWindow else { return }
                self.reloadPlayer()
                window.sheetParent?.endSheet(window)
            }
            let hostingController = NSHostingController(rootView: preferencesView)
            let window = NSWindow(contentViewController: hostingController)
            window.title = "Brooklyn Preferences"
            window.styleMask = [.titled, .closable]
            window.setContentSize(NSSize(width: 600, height: 500))
            preferencesWindow = window
        }
        return preferencesWindow
    }
}
