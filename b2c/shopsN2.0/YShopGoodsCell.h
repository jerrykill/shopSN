//
//  YShopGoodsCell.h
//  shopsN
//
//  Created by imac on 2016/11/30.
//  Copyright © 2016年 联系QQ:1084356436. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "YGoodShopModel.h"

@protocol YShopGoodsCellDelegate <NSObject>

-(void)choose:(BOOL)sender index:(NSInteger)tag;

@end

@interface YShopGoodsCell : UICollectionViewCell

@property (strong,nonatomic) YShopGoodModel *model;

@property (weak,nonatomic) id<YShopGoodsCellDelegate>delegate;

@end
