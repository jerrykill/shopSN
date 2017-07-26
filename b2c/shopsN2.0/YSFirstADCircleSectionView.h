//
//  YSFirstADCircleSectionView.h
//  shopsN2.0
//
//  Created by imac on 2017/7/4.
//  Copyright © 2017年 联系QQ:1084356436. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "YHeadImage.h"

@protocol YSFirstADCircleSectionViewDelegate <NSObject>

- (void)chooseSectionADPush:(NSString*)className  Id:(NSString*)sender;

@end

@interface YSFirstADCircleSectionView : UICollectionReusableView

@property (strong,nonatomic) YHeadImage *model;

@property (weak,nonatomic) id<YSFirstADCircleSectionViewDelegate>delegate;

@end
