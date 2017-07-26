//
//  YServiceAskCell.h
//  shopsN
//
//  Created by imac on 2017/1/4.
//  Copyright © 2017年 联系QQ:1084356436. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "YServiceAskModel.h"
@protocol YServiceAskCellDelegate <NSObject>

-(void)getQuestion:(NSInteger)type index:(NSInteger)index;

@end


@interface YServiceAskCell : UICollectionViewCell

@property (strong,nonatomic) NSString *title;

@property (strong,nonatomic) NSArray <YServiceTitleModel*>*titleArr;

@property (weak,nonatomic) id<YServiceAskCellDelegate>delegate;

@end
