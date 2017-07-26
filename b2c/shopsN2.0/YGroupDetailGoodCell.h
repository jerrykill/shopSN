//
//  YGroupDetailGoodCell.h
//  shopsN
//
//  Created by imac on 2016/12/19.
//  Copyright © 2016年 联系QQ:1084356436. All rights reserved.
//

#import "BaseTableViewCell.h"
#import "YGoodShopModel.h"

@protocol YGroupDetailGoodCellDelegate <NSObject>

- (void)chooseEvaluate:(YShopGoodModel*)model;

@end

@interface YGroupDetailGoodCell : BaseTableViewCell

@property (strong,nonatomic) YShopGoodModel *model;

@property (strong,nonatomic) NSString *status;

@property (weak,nonatomic) id<YGroupDetailGoodCellDelegate>delegate;

@end
