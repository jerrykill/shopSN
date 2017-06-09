//
//  YCustomPayDetailCell.h
//  shopsN
//
//  Created by imac on 2017/3/30.
//  Copyright © 2017年 联系QQ:1084356436. All rights reserved.
//

#import "BaseTableViewCell.h"

@protocol YCustomPayDetailCellDelegate <NSObject>

- (void)getDetail:(NSString*)detail index:(NSInteger)index;

@end

@interface YCustomPayDetailCell : BaseTableViewCell

@property (strong,nonatomic) NSString *title;

@property (strong,nonatomic) NSString *detail;

@property (weak,nonatomic) id<YCustomPayDetailCellDelegate>delegate;

@end
