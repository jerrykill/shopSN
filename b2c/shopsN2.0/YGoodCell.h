//
//  YGoodCell.h
//  shopsN
//
//  Created by imac on 2016/11/29.
//  Copyright © 2016年 联系QQ:1084356436. All rights reserved.
//

#import "BaseTableViewCell.h"
#import "YGoodsModel.h"

@protocol YGoodCellDelegate  <NSObject>

-(void)GoodListAction:(NSInteger)sender index:(NSInteger)tag;

@end

@interface YGoodCell : BaseTableViewCell

@property (strong,nonatomic) YGoodsModel *model;

@property (weak,nonatomic) id<YGoodCellDelegate>delegate;

@end
