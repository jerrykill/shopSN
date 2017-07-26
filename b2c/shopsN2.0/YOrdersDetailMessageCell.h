//
//  YOrdersDetailMessageCell.h
//  shopsN
//
//  Created by imac on 2016/12/20.
//  Copyright © 2016年 联系QQ:1084356436. All rights reserved.
//

#import "BaseTableViewCell.h"

@protocol YOrdersDetailMessageCellDelegate <NSObject>

- (void)ordesDetailMessage:(NSString*)sender;

@end

@interface YOrdersDetailMessageCell : BaseTableViewCell

@property (strong,nonatomic) UITextView *inputTV;

@property (strong,nonatomic) NSString *warn;

@property (strong,nonatomic) NSString *title;

@property (weak,nonatomic) id<YOrdersDetailMessageCellDelegate>delegate;

@end
