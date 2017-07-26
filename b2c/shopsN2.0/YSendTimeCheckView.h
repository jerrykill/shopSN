//
//  YSendTimeCheckView.h
//  shopsN
//
//  Created by imac on 2016/12/22.
//  Copyright © 2016年 联系QQ:1084356436. All rights reserved.
//

#import "BaseView.h"


@protocol YSendTimeCheckViewDelegate <NSObject>

-(void)chooseTime:(NSString*)time day:(NSString*)day;

@end
@interface YSendTimeCheckView : BaseView

@property (strong,nonatomic) NSMutableArray *dataArr;


@property (weak,nonatomic) id<YSendTimeCheckViewDelegate>delegate;
@end
