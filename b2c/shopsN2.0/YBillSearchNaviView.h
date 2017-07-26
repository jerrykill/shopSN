//
//  YBillSearchNaviView.h
//  shopsN
//
//  Created by imac on 2016/12/27.
//  Copyright © 2016年 联系QQ:1084356436. All rights reserved.
//

#import "BaseView.h"

@protocol YBillSearchNaviViewDelegate <NSObject>

-(void)chooseBack;

-(void)rightAction;

-(void)searchDid:(NSString *)text;

@end

@interface YBillSearchNaviView : BaseView

@property (strong,nonatomic) UITextField *searchTF;

@property (weak,nonatomic) id<YBillSearchNaviViewDelegate>delegate;

@end
