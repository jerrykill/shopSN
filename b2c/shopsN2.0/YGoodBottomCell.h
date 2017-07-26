//
//  YGoodBottomCell.h
//  shopsN
//
//  Created by imac on 2016/12/14.
//  Copyright © 2016年 联系QQ:1084356436. All rights reserved.
//

#import <UIKit/UIKit.h>

@protocol YGoodBottomCellDelegate <NSObject>

-(void)getHeadFresh;

-(void)putQuestions:(NSString *)text;

-(void)chooseType:(NSInteger)index;

@end

@interface YGoodBottomCell : UICollectionViewCell

@property (strong,nonatomic) UIScrollView *baseV;

@property (strong,nonatomic) NSString *goodID;

@property (weak,nonatomic) id<YGoodBottomCellDelegate>delegate;

@end
