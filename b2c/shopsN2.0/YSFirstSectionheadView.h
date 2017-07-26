//
//  YSFirstSectionheadView.h
//  shopsN2.0
//
//  Created by imac on 2017/7/4.
//  Copyright © 2017年 联系QQ:1084356436. All rights reserved.
//

#import <UIKit/UIKit.h>

@protocol YSFirstSectionheadViewDelegate <NSObject>

- (void)lookClassSection:(NSInteger)index;

@end

@interface YSFirstSectionheadView : UICollectionReusableView

@property (strong,nonatomic) NSString *className;

@property (weak,nonatomic) id<YSFirstSectionheadViewDelegate>delegate;

@end
