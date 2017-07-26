//
//  YPromotionBOXCell.h
//  shopsN
//
//  Created by imac on 2016/12/12.
//  Copyright © 2016年 联系QQ:1084356436. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "YGoodsModel.h"

@protocol YPromotionBOXCellDelegate <NSObject>

-(void)chooseBoxGood:(YGoodsModel*)model;

@end

@interface YPromotionBOXCell : UICollectionViewCell

@property (strong,nonatomic) NSMutableArray<YGoodsModel*> *goodArr;

@property (weak,nonatomic) id<YPromotionBOXCellDelegate>delegate;

@end
