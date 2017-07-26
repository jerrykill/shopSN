//
//  YSBrandGoodCell.h
//  shopsN2.0
//
//  Created by imac on 2017/7/5.
//  Copyright © 2017年 联系QQ:1084356436. All rights reserved.
//

#import "BaseTableViewCell.h"
#import "YGoodsModel.h"

static inline CGFloat AutoWidth(CGFloat width){
    return width*__kWidth/375;
}

@interface YSBrandGoodCell : BaseTableViewCell

@property (strong,nonatomic) YGoodsModel *model;

@end
