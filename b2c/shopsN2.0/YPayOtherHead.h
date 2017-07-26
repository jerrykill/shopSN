//
//  YPayOtherHead.h
//  shopsN
//
//  Created by imac on 2016/12/23.
//  Copyright © 2016年 联系QQ:1084356436. All rights reserved.
//

#import "BaseView.h"

@protocol YPayOtherHeadDelegate <NSObject>

-(void)choosePay;

@end

@interface YPayOtherHead : BaseView

@property (strong,nonatomic) NSString *title;

@property (weak,nonatomic) id<YPayOtherHeadDelegate>delegate;

@end
