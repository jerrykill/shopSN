//
//  YPromotionActiveView.h
//  shopsN
//
//  Created by imac on 2016/12/12.
//  Copyright © 2016年 联系QQ:1084356436. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "YPromotionClassModel.h"

@protocol YPromotionActiveViewDelegate <NSObject>

-(void)chooseTagV:(NSString *)sender;

- (void)chooseCLass:(YPromotionClassModel*)model;

@end

@interface YPromotionActiveView : UICollectionReusableView

@property (strong,nonatomic) NSArray <YPromotionClassModel*>*dataArr;

@property (weak,nonatomic) id<YPromotionActiveViewDelegate>delegate;

@end
