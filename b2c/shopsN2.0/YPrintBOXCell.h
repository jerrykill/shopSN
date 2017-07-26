//
//  YPrintBOXCell.h
//  shopsN
//
//  Created by imac on 2016/11/30.
//  Copyright © 2016年 联系QQ:1084356436. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "YGoodsModel.h"
@protocol YPrintBOXCellDelegate <NSObject>

-(void)chooseGood:(YGoodsModel*)model;

@end

@interface YPrintBOXCell : UICollectionViewCell

@property (strong,nonatomic) NSMutableArray<YGoodsModel *> *goodArr;

@property (weak,nonatomic) id<YPrintBOXCellDelegate>delegate;
@end
