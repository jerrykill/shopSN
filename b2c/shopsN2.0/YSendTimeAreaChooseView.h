//
//  YSendTimeAreaChooseView.h
//  shopsN
//
//  Created by imac on 2016/12/22.
//  Copyright © 2016年 联系QQ:1084356436. All rights reserved.
//

#import "BaseView.h"

@protocol YSendTimeAreaChooseViewDelegate <NSObject>

-(void)chooseSendTime:(NSString *)str;

@end

@interface YSendTimeAreaChooseView : BaseView

@property (weak,nonatomic) id<YSendTimeAreaChooseViewDelegate>delegate;

@end
