//
//  YLogisicsInfoCell.h
//  shopsN
//
//  Created by imac on 2016/12/26.
//  Copyright © 2016年 联系QQ:1084356436. All rights reserved.
//

#import "BaseTableViewCell.h"
#import "YLogisicsInfoModel.h"

@interface YLogisicsInfoCell : BaseTableViewCell

//@property (strong,nonatomic) NSString *title;
//
//@property (strong,nonatomic) NSString *time;
//
//@property (strong,nonatomic) NSString *name;

@property (strong,nonatomic) YLogisicsInfoModel *data;

@property (nonatomic) NSInteger type;

@end
