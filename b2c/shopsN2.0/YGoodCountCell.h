//
//  YGoodCountCell.h
//  shopsN
//
//  Created by imac on 2016/12/15.
//  Copyright © 2016年 联系QQ:1084356436. All rights reserved.
//

#import <UIKit/UIKit.h>

@protocol YGoodCountCellDelegate <NSObject>

-(void)countChange:(BOOL)sender;

@end

@interface YGoodCountCell : UICollectionViewCell

@property (strong,nonatomic) NSString *stock;

@property (strong,nonatomic) NSString *num;

@property (weak,nonatomic) id<YGoodCountCellDelegate>delegate;

@end
