//
//  YPersonDetailHeadView.h
//  shopsN
//
//  Created by imac on 2016/12/17.
//  Copyright © 2016年 联系QQ:1084356436. All rights reserved.
//

#import <UIKit/UIKit.h>

@protocol YPersonDetailHeadViewDelegate <NSObject>

//-(void)headTitleActionType:(NSInteger)tag;

-(void)headDetailActionType:(NSInteger)tag;

@end

@interface YPersonDetailHeadView : UICollectionReusableView

@property (strong,nonatomic) NSString *title;

@property (strong,nonatomic) NSString *detail;

@property (weak,nonatomic) id<YPersonDetailHeadViewDelegate>delegate;

@end
