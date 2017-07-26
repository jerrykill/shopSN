//
//  YSTimeSetctionHeadView.h
//  shopsN2.0
//
//  Created by imac on 2017/7/3.
//  Copyright © 2017年 联系QQ:1084356436. All rights reserved.
//

#import <UIKit/UIKit.h>

@protocol YSTimeSetctionHeadViewDelegate <NSObject>

- (void)lookClearanceMore;

@end

@interface YSTimeSetctionHeadView : UICollectionReusableView

@property (strong,nonatomic) NSString *time;

@property (weak,nonatomic) id<YSTimeSetctionHeadViewDelegate>delegate;

@end
