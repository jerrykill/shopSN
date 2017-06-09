//
//  YBuyingGoodPicCell.h
//  shopsN
//
//  Created by imac on 2016/12/28.
//  Copyright © 2016年 联系QQ:1084356436. All rights reserved.
//

#import "BaseTableViewCell.h"

@protocol YBuyingGoodPicCellDelegate <NSObject>

-(void)deletePicIndex:(NSInteger)sender;

-(void)addPhotos;

@end

@interface YBuyingGoodPicCell : BaseTableViewCell

@property (strong,nonatomic) NSMutableArray *imageArr;

@property (strong,nonatomic) NSString *title;

@property (weak,nonatomic) id<YBuyingGoodPicCellDelegate>delegate;

@end
