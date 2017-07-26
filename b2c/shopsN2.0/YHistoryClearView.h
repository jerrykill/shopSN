//
//  YHistoryClearView.h
//  shopsN
//
//  Created by imac on 2016/12/1.
//  Copyright © 2016年 联系QQ:1084356436. All rights reserved.
//

#import <UIKit/UIKit.h>

@protocol  YHistoryClearViewDelegate<NSObject>

-(void)clear;

@end

@interface YHistoryClearView : UICollectionReusableView

@property (weak,nonatomic) id<YHistoryClearViewDelegate>delegate;

@end
