//
//  YBillTypeCell.h
//  shopsN
//
//  Created by imac on 2016/12/22.
//  Copyright © 2016年 联系QQ:1084356436. All rights reserved.
//

#import "BaseTableViewCell.h"

@protocol YBillTypeCellDelegate <NSObject>

-(void)chooseType:(NSString *)type index:(NSInteger)tag;

@end

@interface YBillTypeCell : BaseTableViewCell

@property (strong,nonatomic) NSString *head;

@property (strong,nonatomic) NSMutableArray *dataArr;

@property (strong,nonatomic) NSString *choose;

@property (weak,nonatomic) id<YBillTypeCellDelegate>delegate;

@end
