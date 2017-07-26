//
//  YShopCartHeadView.h
//  shopsN
//
//  Created by imac on 2016/12/16.
//  Copyright © 2016年 联系QQ:1084356436. All rights reserved.
//

#import <UIKit/UIKit.h>

@protocol YShopCartHeadViewDelegate <NSObject>

-(void)chooseAll:(BOOL)sender;

-(void)AllEdit:(BOOL)sender;

@end

@interface YShopCartHeadView : UICollectionReusableView

@property (nonatomic) BOOL allChoose;


@property (weak,nonatomic) id<YShopCartHeadViewDelegate>delegate;

@end
