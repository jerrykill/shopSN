//
//  YSOrderGoodCell.h
//  shopsN2.0
//
//  Created by imac on 2017/7/21.
//  Copyright © 2017年 联系QQ:1084356436. All rights reserved.
//

#import "BaseTableViewCell.h"
#import "YSOrderModel.h"

@protocol YSOrderGoodCellDelegate <NSObject>

@optional

- (void)chooseAction:(NSInteger)sender;

- (void)orderDelete:(NSInteger)index;


@end

@interface YSOrderGoodCell : BaseTableViewCell

@property (strong,nonatomic) YSOrderModel *model;

@property (weak,nonatomic) id<YSOrderGoodCellDelegate>delegate;

@end
