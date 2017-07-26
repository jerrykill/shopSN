//
//  YSettingCell.h
//  shopsN
//
//  Created by imac on 2016/12/19.
//  Copyright © 2016年 联系QQ:1084356436. All rights reserved.
//

#import "BaseTableViewCell.h"

@protocol YSettingCellDelegate <NSObject>

-(void)chooseSwitch:(BOOL)sender index:(NSInteger)tag;

@end

@interface YSettingCell : BaseTableViewCell

@property (strong,nonatomic) NSString *title;


@property (strong,nonatomic) UILabel *detailLb;

@property (strong,nonatomic) UISwitch *switChoose;

@property (weak,nonatomic) id<YSettingCellDelegate>delegate;

@end
