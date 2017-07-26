//
//  YGoodReturnsCell.h
//  shopsN
//
//  Created by imac on 2017/1/4.
//  Copyright © 2017年 联系QQ:1084356436. All rights reserved.
//

#import "BaseTableViewCell.h"
#import "YReturnsOrdersModel.h"

@protocol YGoodReturnsCellDelegate <NSObject>

-(void)chooseAction:(NSInteger)index;

@end

@interface YGoodReturnsCell : BaseTableViewCell

@property (strong,nonatomic) YReturnsGoodModel *model;

@property (weak,nonatomic) id<YGoodReturnsCellDelegate>delegate;

@end
