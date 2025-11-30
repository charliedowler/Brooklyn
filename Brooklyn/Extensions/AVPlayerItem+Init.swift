//
//  AVPlayerItem+Init.swift
//  Brooklyn
//
//  Created by Pedro Carrasco on 19/02/2019.
//  Copyright © 2019 Pedro Carrasco. All rights reserved.
//

import AVKit
import os.log

private let logger = Logger(subsystem: "oedrommcarrasco.brooklyn", category: "AVPlayerItem")

// MARK: Init
extension AVPlayerItem {

    convenience init?(video: Animation, extension ext: Extension, for caller: AnyClass) {
        let bundle = Bundle(for: caller)
        logger.info("Looking for video \(video.rawValue) in bundle: \(bundle.bundlePath)")

        guard let url = bundle.url(forResource: video.rawValue, withExtension: ext.rawValue) else {
            logger.error("Failed to find video: \(video.rawValue).\(ext.rawValue)")
            return nil
        }
        logger.info("Found video at: \(url.path)")
        self.init(url: url)
    }
}
