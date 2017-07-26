//
//  YPromotionSpecialCell.h
//  shopsN
//
//  Created by imac on 2016/12/12.
//  Copyright © 2016年 联系QQ:1084356436. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "YGoodsModel.h"

@protocol YPromotionSpecialCellDelegate <NSObject>

-(void)chooseSpecialGood:(NSInteger)tag;

@end

@interface YPromotionSpecialCell : UICollectionViewCell

@property (strong,nonatomic) YGoodsModel*model;

@property (weak,nonatomic) id<YPromotionSpecialCellDelegate>delegate;

@end
