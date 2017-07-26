//
//  YApplayDrawbackSuccessView.h
//  shopsN
//
//  Created by imac on 2017/1/7.
//  Copyright © 2017年 联系QQ:1084356436. All rights reserved.
//

#import "BaseView.h"

@protocol YApplayDrawbackSuccessViewDelegate <NSObject>

-(void)continueBuy;

@end

@interface YApplayDrawbackSuccessView : BaseView

@property (weak,nonatomic) id<YApplayDrawbackSuccessViewDelegate>delegate;

@end
