//
//  YGoodShopOneCell.h
//  shopsN
//
//  Created by imac on 2016/12/16.
//  Copyright © 2016年 联系QQ:1084356436. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "YGoodShopModel.h"

@protocol YGoodShopOneCellDelegate <NSObject>

-(void)countChange:(BOOL)sender index:(NSInteger)tag;

-(void)chooses:(BOOL)sender index:(NSInteger)tag;

-(void)deleteIndex:(NSInteger)tag;

-(void)chooseEdit:(NSInteger)tag;

@end


@interface YGoodShopOneCell : UICollectionViewCell

@property (strong,nonatomic) YShopGoodModel *model;

@property (weak,nonatomic) id<YGoodShopOneCellDelegate>delegate;

@end
