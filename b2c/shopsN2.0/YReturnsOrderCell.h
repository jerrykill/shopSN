//
//  YReturnsOrderCell.h
//  shopsN
//
//  Created by imac on 2017/1/4.
//  Copyright © 2017年 联系QQ:1084356436. All rights reserved.
//

#import "BaseTableViewCell.h"
#import "YReturnsOrdersModel.h"

@protocol YReturnsOrderCellDelegate <NSObject>

-(void)chooseAction:(NSInteger)index tag:(NSInteger)sender;

@end

@interface YReturnsOrderCell : BaseTableViewCell

@property (strong,nonatomic) YReturnsOrdersModel *model ;


@property (weak,nonatomic) id <YReturnsOrderCellDelegate>delegate;

@end
