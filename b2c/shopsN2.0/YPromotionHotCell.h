//
//  YPromotionHotCell.h
//  shopsN
//
//  Created by imac on 2016/12/12.
//  Copyright © 2016年 联系QQ:1084356436. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "YGoodsModel.h"

@interface YPromotionHotCell : UICollectionViewCell

@property (strong,nonatomic) UILabel *titleLb;

@property (strong,nonatomic) UIButton *moneyBtn;

@property (strong,nonatomic) YGoodsModel *model;

@end
