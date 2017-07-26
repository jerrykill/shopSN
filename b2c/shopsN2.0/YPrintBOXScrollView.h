//
//  YPrintBOXScrollView.h
//  shopsN
//
//  Created by imac on 2016/11/30.
//  Copyright © 2016年 联系QQ:1084356436. All rights reserved.
//

#import "BaseView.h"
#import "YGoodsModel.h"

@protocol YPrintBOXScrollViewDelegate <NSObject>

-(void)chooseGood:(YGoodsModel*)sender;

@end

@interface YPrintBOXScrollView : BaseView

@property (strong,nonatomic) NSMutableArray<YGoodsModel*>*goodArr;

@property (weak,nonatomic) id<YPrintBOXScrollViewDelegate>delegate;

@end
