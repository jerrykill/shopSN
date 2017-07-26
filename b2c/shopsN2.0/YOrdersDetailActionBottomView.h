//
//  YOrdersDetailActionBottomView.h
//  shopsN
//
//  Created by imac on 2016/12/21.
//  Copyright © 2016年 联系QQ:1084356436. All rights reserved.
//

#import "BaseView.h"

@protocol YOrdersDetailActionBottomViewDelegate <NSObject>

-(void)OrderBottomAction:(NSInteger)sender;

@end

@interface YOrdersDetailActionBottomView : BaseView

@property (strong,nonatomic) NSString *status;

@property (weak,nonatomic) id<YOrdersDetailActionBottomViewDelegate>delegate;

@end
