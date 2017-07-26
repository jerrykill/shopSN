//
//  YJkPushTool.m
//  shopsN
//   本地推送提醒类
//  Created by imac on 2017/3/17.
//  Copyright © 2017年 联系QQ:1084356436. All rights reserved.
//

#import "YJkPushTool.h"

static YJkPushTool *_sharedInstance;//震动对象全局变量
static YJkPushTool *_sharedInstanceForSound;//声音对象全局变量

@implementation YJkPushTool
#pragma mark ==获取震动对象==
+(id)sharedInstanceForVibrate{
    if (_sharedInstance==nil) {
        _sharedInstance = [[YJkPushTool alloc]initForPlayingShake];
    }
    return _sharedInstance;
}

+(id)sharedInstanceForSound{
    if (_sharedInstanceForSound == nil) {
        _sharedInstanceForSound = [[YJkPushTool alloc]initForPlayingSound:@"sound.caf"];
    }
    return _sharedInstanceForSound;
}



-(id)initForPlayingShake{
    if (self = [super init]) {
        soundID = kSystemSoundID_Vibrate;
    }
    return self;
}


-(id)initForPlayingSound:(NSString *)fileName{
    if (self = [super init]) {
        NSURL *fileURL = [[NSBundle mainBundle]URLForResource:fileName withExtension:nil];
        if (fileURL!=nil) {
            SystemSoundID theSoundID;
            OSStatus error = AudioServicesCreateSystemSoundID((__bridge CFURLRef)fileURL, &theSoundID);
            if (error == kAudioServicesNoError) {
                soundID = theSoundID;
            }else{
                NSLog(@"Failed to create sound");
            }
        }
    }
    return self;
}

-(void)play{
    AudioServicesPlaySystemSound(soundID);
}

-(void)dealloc{
    AudioServicesDisposeSystemSoundID(soundID);
}
@end
