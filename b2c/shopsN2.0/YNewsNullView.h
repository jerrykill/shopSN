//
//  YNewsNullView.h
//  shopsN
//
//  Created by imac on 2017/2/7.
//  Copyright © 2017年 联系QQ:1084356436. All rights reserved.
//

#import "BaseView.h"

@protocol YNewsNullViewDelegate <NSObject>

- (void)goBuying;

@end

@interface YNewsNullView : BaseView

@property (weak,nonatomic) id<YNewsNullViewDelegate>delegate;

@end
