//
//  YOrderdetailHeadCell.h
//  shopsN
//
//  Created by imac on 2016/12/20.
//  Copyright © 2016年 联系QQ:1084356436. All rights reserved.
//

#import "BaseTableViewCell.h"

@interface YOrderdetailHeadCell : BaseTableViewCell
/**订单编号*/
@property (strong,nonatomic) NSString *orderNo;
/**订单状态*/
@property (strong,nonatomic) NSString *status;
@end
