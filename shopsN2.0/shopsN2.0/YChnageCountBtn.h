//
//  YChnageCountBtn.h
//  shopsN
//
//  Created by imac on 2016/12/7.
//  Copyright © 2016年 联系QQ:1084356436. All rights reserved.
//

#import "BaseView.h"

@protocol YChnageCountBtnDelegate <NSObject>

-(void)changeCount:(BOOL)sender;

@end

@interface YChnageCountBtn : BaseView

@property (strong,nonatomic) NSString *count;

@property (weak,nonatomic) id<YChnageCountBtnDelegate>delegate;

@end
