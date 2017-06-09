//
//  YBankCardChooseView.h
//  shopsN
//
//  Created by imac on 2016/12/24.
//  Copyright © 2016年 联系QQ:1084356436. All rights reserved.
//

#import "BaseView.h"

@protocol YBankCardChooseViewDelegate <NSObject>

-(void)chooseBank:(NSString *)bank;

@end

@interface YBankCardChooseView : BaseView

@property (strong,nonatomic) NSMutableArray *bankArr;

@property (weak,nonatomic) id<YBankCardChooseViewDelegate>delegate;

@end
