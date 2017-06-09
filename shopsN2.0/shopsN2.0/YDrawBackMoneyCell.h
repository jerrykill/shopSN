//
//  YDrawBackMoneyCell.h
//  shopsN
//
//  Created by imac on 2016/12/24.
//  Copyright © 2016年 联系QQ:1084356436. All rights reserved.
//

#import "BaseTableViewCell.h"

@protocol YDrawBackMoneyCellDelegate <NSObject>

-(void)getApplyMoney:(NSString *)money;


@end

@interface YDrawBackMoneyCell : BaseTableViewCell

@property (strong,nonatomic) NSString *money;

@property (strong,nonatomic) NSString *fright;

@property (strong,nonatomic) NSString *applyMoney;

@property (weak,nonatomic) id<YDrawBackMoneyCellDelegate>delegate;

@end
