//
//  YSFirstPromotionGoodCell.h
//  shopsN2.0
//
//  Created by imac on 2017/7/4.
//  Copyright © 2017年 联系QQ:1084356436. All rights reserved.
//

#import <UIKit/UIKit.h>

@protocol YSFirstPromotionGoodCellDelegate <NSObject>

- (void)choosePromotionGood:(YGoodsModel*)model;

@end

@interface YSFirstPromotionGoodCell : UICollectionViewCell

@property (strong,nonatomic) NSMutableArray <YGoodsModel*>*goodArr;

@property (weak,nonatomic) id<YSFirstPromotionGoodCellDelegate>delegate;

@end
