//
//  YBuyingOrderTitleCell.h
//  shopsN
//
//  Created by imac on 2016/12/28.
//  Copyright © 2016年 联系QQ:1084356436. All rights reserved.
//

#import "BaseTableViewCell.h"

@protocol YBuyingOrderTitleCellDelegate <NSObject>

-(void)Getdetail:(NSString *)sender Index:(NSInteger)tag;


@end

@interface YBuyingOrderTitleCell : BaseTableViewCell

@property (strong,nonatomic) NSString *title;

@property (strong,nonatomic) NSString *detail;

@property (strong,nonatomic) NSString *plachor;

@property (nonatomic) BOOL edit;

@property (weak,nonatomic) id<YBuyingOrderTitleCellDelegate>delegate;

@end
