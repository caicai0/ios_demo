//
//  SampleHandler.swift
//  Upload
//
//  Created by 李玉峰 on 2018/4/25.
//  Copyright © 2018年 cai. All rights reserved.
//

import ReplayKit

class SampleHandler: RPBroadcastSampleHandler {
    
    var encodePush :EncodeAndPush? = nil
    
    
    override func broadcastStarted(withSetupInfo setupInfo: [String : NSObject]?) {
        let videoConfiguration : LFLiveVideoConfiguration = LFLiveVideoConfiguration()
        let audioConfiguration : LFLiveAudioConfiguration = LFLiveAudioConfiguration()
        encodePush = EncodeAndPush(audioConfiguration: audioConfiguration, videoConfiguration: videoConfiguration)
        encodePush?.running = true
    }
    
    override func broadcastPaused() {
        
    }
    
    override func broadcastResumed() {
        
    }
    
    override func broadcastFinished() {
        
    }
    
    override func processSampleBuffer(_ sampleBuffer: CMSampleBuffer, with sampleBufferType: RPSampleBufferType) {
        switch sampleBufferType {
            case RPSampleBufferType.video:
                
                break
            case RPSampleBufferType.audioApp:
                
                break
            case RPSampleBufferType.audioMic:
                
                break
        }
    }
}
