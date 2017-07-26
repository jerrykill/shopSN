//
//  YBillHeadCell.h
//  shopsN
//
//  Created by imac on 2016/12/22.
//  Copyright © 2016年 联系QQ:1084356436. All rights reserved.
//

#import "BaseTableViewCell.h"

@protocol YBillHeadCellDelegate <NSObject>

-(void)chooseHeadType:(NSString *)type head:(NSString *)head;

@end

@interface YBillHeadCell : BaseTableViewCell

@property (strong,nonatomic) NSString *headType;

@property (strong,nonatomic) NSString *header;

@property (weak,nonatomic) id<YBillHeadCellDelegate>delegate;

@end
