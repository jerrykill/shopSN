//
//  YPromotionFirstCell.h
//  shopsN
//
//  Created by imac on 2016/12/12.
//  Copyright © 2016年 联系QQ:1084356436. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "YGoodsModel.h"


@protocol YPromotionFirstCellDelegate <NSObject>

-(void)chooseGood:(YGoodsModel*)sender;

-(void)chooseHot:(YGoodsModel*)sender;

@end

@interface YPromotionFirstCell : UICollectionViewCell

@property (strong,nonatomic) YGoodsModel *hot;

@property (strong,nonatomic) YGoodsModel *good;

@property (strong,nonatomic) NSString *imageName;

@property (weak,nonatomic) id<YPromotionFirstCellDelegate>delegate;

@end
