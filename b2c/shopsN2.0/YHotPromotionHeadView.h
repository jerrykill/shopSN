//
//  YHotPromotionHeadView.h
//  shopsN
//
//  Created by imac on 2016/12/12.
//  Copyright © 2016年 联系QQ:1084356436. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "YHeadImage.h"

@protocol YHotPromotionHeadViewDelegate <NSObject>

-(void)choosebottomAD:(NSString *)url;

@end

@interface YHotPromotionHeadView : UICollectionReusableView

@property (strong,nonatomic) NSMutableArray<YHeadImage*>*imageArr;

@property (strong,nonatomic) NSString *title;

@property (weak,nonatomic) id<YHotPromotionHeadViewDelegate>delegate;


@end
