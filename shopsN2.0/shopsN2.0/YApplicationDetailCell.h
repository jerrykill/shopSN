//
//  YApplicationDetailCell.h
//  shopsN
//
//  Created by imac on 2016/12/29.
//  Copyright © 2016年 联系QQ:1084356436. All rights reserved.
//

#import "BaseTableViewCell.h"

@protocol YApplicationDetailCellDelegate <NSObject>

-(void)getApplyDetail:(NSString *)text Index:(NSInteger)tag;


- (void)chooseArea;

@end


@interface YApplicationDetailCell : BaseTableViewCell

@property (strong,nonatomic) NSString *title;

@property (strong,nonatomic) NSString *detail;


@property (nonatomic) NSInteger font;

@property (weak,nonatomic) id<YApplicationDetailCellDelegate>delegate;

@end
