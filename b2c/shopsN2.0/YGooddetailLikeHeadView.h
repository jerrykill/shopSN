//
//  YGooddetailLikeHeadView.h
//  shopsN
//
//  Created by imac on 2016/12/13.
//  Copyright © 2016年 联系QQ:1084356436. All rights reserved.
//

#import <UIKit/UIKit.h>

@protocol YGooddetailLikeHeadViewDelegate <NSObject>

-(void)changeNext;

@end

@interface YGooddetailLikeHeadView : UICollectionReusableView

@property (strong,nonatomic) NSString *titles;

@property (weak,nonatomic) id<YGooddetailLikeHeadViewDelegate>delegate;

@end
