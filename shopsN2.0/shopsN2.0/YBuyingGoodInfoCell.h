//
//  YBuyingGoodInfoCell.h
//  shopsN
//
//  Created by imac on 2016/12/28.
//  Copyright © 2016年 联系QQ:1084356436. All rights reserved.
//

#import "BaseTableViewCell.h"

@protocol YBuyingGoodInfoCellDelegate <NSObject>

-(void)getInfoDetail:(NSString*)sender;

@end

@interface YBuyingGoodInfoCell : BaseTableViewCell

@property (strong,nonatomic) NSString *warn;

@property (strong,nonatomic) NSString *title;

@property (strong,nonatomic) NSString *info;

@property (weak,nonatomic) id<YBuyingGoodInfoCellDelegate>delegate;

@end
