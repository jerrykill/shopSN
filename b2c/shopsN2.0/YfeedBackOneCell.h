//
//  YfeedBackOneCell.h
//  shopsN
//
//  Created by imac on 2016/12/6.
//  Copyright © 2016年 联系QQ:1084356436. All rights reserved.
//

#import "BaseTableViewCell.h"

@protocol YfeedBackOneCellDelegate <NSObject>

-(void)choosefeedType;

@end

@interface YfeedBackOneCell : BaseTableViewCell

@property (strong,nonatomic) NSString *type;

@property (weak,nonatomic) id<YfeedBackOneCellDelegate>delegate;

@end
