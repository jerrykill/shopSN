//
//  YCuponViewCell.h
//  shopsN
//
//  Created by imac on 2016/12/22.
//  Copyright © 2016年 联系QQ:1084356436. All rights reserved.
//

#import "BaseTableViewCell.h"
#import "YScouponModel.h"

@protocol YCuponViewCellDelegate <NSObject>

-(void)chooseUseTag:(NSInteger)index;

@end

@interface YCuponViewCell : BaseTableViewCell

@property (nonatomic) NSInteger color;

@property (strong,nonatomic) YScouponModel *model;

@property (weak,nonatomic) id<YCuponViewCellDelegate>delegate;

@end
