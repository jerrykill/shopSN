//
//  YDrawBackInputCell.h
//  shopsN
//
//  Created by imac on 2016/12/24.
//  Copyright © 2016年 联系QQ:1084356436. All rights reserved.
//

#import "BaseTableViewCell.h"

@protocol YDrawBackInputCellDelegate <NSObject>

-(void)addPhotos;

-(void)deletePicIndex:(NSInteger)index;

-(void)getInputText:(NSString *)text;


@end

@interface YDrawBackInputCell : BaseTableViewCell

@property (strong,nonatomic) NSMutableArray *imageArr;

@property (weak,nonatomic) id<YDrawBackInputCellDelegate>delegate;

@end
