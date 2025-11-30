//
//  Database.swift
//  Brooklyn
//
//  Created by Pedro Carrasco on 21/02/2019.
//  Copyright © 2019 Pedro Carrasco. All rights reserved.
//

import ScreenSaver
import os.log

private let logger = Logger(subsystem: "oedrommcarrasco.brooklyn", category: "Database")

// MARK: Database
struct Database {

    // MARK: Constant
    private static let bundleIdentifier = "oedrommcarrasco.brooklyn"

    // MARK: Key
    fileprivate enum Key {
        static let selectedAnimations = "selectedAnimations"
        static let numberOfLoops = "numberOfLoops"
        static let randomOrder = "randomOrder"
    }

    // MARK: Properties
    static var standard: ScreenSaverDefaults {
        guard let database = ScreenSaverDefaults(forModuleWithName: bundleIdentifier)
            else { fatalError("Failed to retrieve database for \(bundleIdentifier)") }

        database.register(defaults:
            [Key.selectedAnimations: [Animation.original.rawValue],
             Key.numberOfLoops: 0,
             Key.randomOrder: false
             ]
        )

        return database
    }
}

// MARK: - ScreenSaverDefaults's Functions
extension ScreenSaverDefaults {

    var selectedAnimations: [Animation] {
        guard let rawValues = array(forKey: Database.Key.selectedAnimations) as? [String] else {
            logger.info("No saved animations, using default")
            return [.original]
        }
        let animations = rawValues.compactMap(Animation.init)
        logger.info("Loaded \(animations.count) animations")
        return animations.isEmpty ? [.original] : animations
    }

    func set(animations: [Animation]) {
        logger.info("Saving \(animations.count) animations")
        set(animations.map { $0.rawValue }, for: Database.Key.selectedAnimations)
    }

    var numberOfLoops: Int {
        let loops = integer(forKey: Database.Key.numberOfLoops)
        logger.info("Loaded numberOfLoops: \(loops)")
        return loops
    }

    func set(numberOfLoops: Int) {
        set(numberOfLoops, for: Database.Key.numberOfLoops)
    }

    var hasRandomOrder: Bool {
        let random = bool(forKey: Database.Key.randomOrder)
        logger.info("Loaded hasRandomOrder: \(random)")
        return random
    }

    func set(hasRandomOrder: Bool) {
        set(hasRandomOrder, for: Database.Key.randomOrder)
    }
}

// MARK: - ScreenSaverDefaults's Private Functions
private extension ScreenSaverDefaults {

    func set(_ object: Any, for key: String) {
        set(object, forKey: key)
        // Required for screensaver extension to persist immediately
        synchronize()
    }
}
