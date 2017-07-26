//
//  YSFirstADSctionHeadView.h
//  shopsN2.0
//
//  Created by imac on 2017/7/4.
//  Copyright © 2017年 联系QQ:1084356436. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "YHeadImage.h"

@protocol YSFirstADSctionHeadViewDelegate <NSObject>

- (void)chooseSectionclass:(NSInteger)index;

- (void)chooseADPush:(NSString*)name Id:(NSString*)sender;

@end

@interface YSFirstADSctionHeadView : UICollectionReusableView

@property (strong,nonatomic) NSString *className;

@property (strong,nonatomic) YHeadImage *model;

@property (weak,nonatomic) id<YSFirstADSctionHeadViewDelegate>delegate;

@end
