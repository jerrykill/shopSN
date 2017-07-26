//
//  YGoodDetailWayColorCell.h
//  shopsN
//
//  Created by imac on 2016/12/15.
//  Copyright © 2016年 联系QQ:1084356436. All rights reserved.
//

#import <UIKit/UIKit.h>


@protocol YGoodDetailWayColorCellDelegate <NSObject>

-(void)chooseType:(NSInteger)idx index:(NSInteger)sender;

@end

@interface YGoodDetailWayColorCell : UICollectionViewCell

@property (strong,nonatomic) NSMutableArray<YSSizeModel*> *BtnArr;

@property (strong,nonatomic) NSString *title;

@property (strong,nonatomic) NSString *check;



@property (weak,nonatomic) id<YGoodDetailWayColorCellDelegate>delegate;

@end
