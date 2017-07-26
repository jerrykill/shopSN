//
//  YPicInputCell.h
//  shopsN
//
//  Created by imac on 2016/12/24.
//  Copyright © 2016年 联系QQ:1084356436. All rights reserved.
//

#import <UIKit/UIKit.h>

@protocol YPicInputCellDelegate <NSObject>

-(void)deletePic:(NSInteger)index;

@end

@interface YPicInputCell : UICollectionViewCell

@property (strong,nonatomic) UIImage *image;

@property (nonatomic) BOOL isAdd;

@property (weak,nonatomic) id<YPicInputCellDelegate>delegate;

@end
