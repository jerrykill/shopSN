//
//  YBuyingOrderDateCell.h
//  shopsN
//
//  Created by imac on 2016/12/28.
//  Copyright © 2016年 联系QQ:1084356436. All rights reserved.
//

#import "BaseTableViewCell.h"

@protocol YBuyingOrderDateCellDelegate <NSObject>

-(void)getDate:(NSString *)date;

-(void)changeFramed;


@end

@interface YBuyingOrderDateCell : BaseTableViewCell

@property (strong,nonatomic) NSString *date;

@property (weak,nonatomic) id<YBuyingOrderDateCellDelegate>delegate;

@end
