//
//  YFisrtSearchView.h
//  shopsN
//
//  Created by imac on 2016/11/30.
//  Copyright © 2016年 联系QQ:1084356436. All rights reserved.
//

#import "BaseView.h"

@protocol YFisrtSearchViewDelegate <NSObject>

- (void)search:(NSString *)sender;

- (void)login;

- (void)SeeMessage;

- (void)QRCodeAction;

@end

@interface YFisrtSearchView : BaseView

@property (weak,nonatomic) id<YFisrtSearchViewDelegate>delegate;

@property (strong,nonatomic)  UIButton *messageBtn;

@end
