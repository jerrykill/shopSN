//
//  YOrderGoodListCell.h
//  shopsN
//
//  Created by imac on 2016/12/7.
//  Copyright © 2016年 联系QQ:1084356436. All rights reserved.
//

#import "BaseTableViewCell.h"
#import "YGoodShopModel.h"

@protocol YOrderGoodListCellDelegate <NSObject>

-(void)changeGoodCount:(BOOL)sender index:(NSInteger)tag;

@end

@interface YOrderGoodListCell : BaseTableViewCell

@property (strong,nonatomic) YShopGoodModel  *model;

@property (weak,nonatomic) id<YOrderGoodListCellDelegate>delegate;

@end
