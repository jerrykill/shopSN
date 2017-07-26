//
//  YGoodDetailHeadView.h
//  shopsN
//
//  Created by imac on 2016/12/13.
//  Copyright © 2016年 联系QQ:1084356436. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "YGoodDetailModel.h"

@protocol YGoodDetailHeadViewDelegate <NSObject>

-(void)ShareGood;

@end

@interface YGoodDetailHeadView : UICollectionReusableView

@property (strong,nonatomic) YGoodDetailModel *model;

@property (weak,nonatomic) id<YGoodDetailHeadViewDelegate>delegate;

@end
