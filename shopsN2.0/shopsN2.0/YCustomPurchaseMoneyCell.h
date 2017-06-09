//
//  YCustomPurchaseMoneyCell.h
//  shopsN
//
//  Created by imac on 2017/3/31.
//  Copyright © 2017年 联系QQ:1084356436. All rights reserved.
//

#import "BaseTableViewCell.h"

@protocol YCustomPurchaseMoneyCellDelegate <NSObject>

- (void)chooseType:(NSString *)type index:(NSInteger)tag;

@end

@interface YCustomPurchaseMoneyCell : BaseTableViewCell

@property (strong,nonatomic) NSMutableArray *dataArr;

@property (strong,nonatomic) NSString *title;

@property (weak,nonatomic) id<YCustomPurchaseMoneyCellDelegate>delegate;

@end
