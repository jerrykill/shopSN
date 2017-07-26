//
//  YJkPushTool.h
//  shopsN
//  本地推送提醒类
//  Created by imac on 2017/3/17.
//  Copyright © 2017年 联系QQ:1084356436. All rights reserved.
//

#import <Foundation/Foundation.h>
#import <AudioToolbox/AudioToolbox.h>

@interface YJkPushTool : NSObject
{
    SystemSoundID soundID;
}
+ (id) sharedInstanceForVibrate;
+ (id) sharedInstanceForSound;

/**震动初始化*/
- (id)initForPlayingShake;
/**铃声初始化*/
- (id)initForPlayingSound:(NSString*)fileName;
/**播放*/
- (void)play;
/**播放声音*/
- (void)playRemind;

@end
