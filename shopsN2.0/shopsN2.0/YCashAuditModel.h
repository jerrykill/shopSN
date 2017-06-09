//
//  YCashAuditModel.h
//  shopsN
//
//  Created by imac on 2016/12/31.
//  Copyright © 2016年 联系QQ:1084356436. All rights reserved.
//

#import "BaseTableViewCell.h"


@interface YCashAuditModel : BaseTableViewCell
/**时间*/
@property (strong,nonatomic) NSString *date;
/**状态*/
@property (strong,nonatomic) NSString *status;
/**详细*/
@property (strong,nonatomic) NSString *detail;

@end
