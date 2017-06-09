//
//  YfeedBackTwoCell.h
//  shopsN
//
//  Created by imac on 2016/12/6.
//  Copyright © 2016年 联系QQ:1084356436. All rights reserved.
//

#import "BaseTableViewCell.h"

@protocol YfeedBackTwoCellDelegate <NSObject>

- (void)connectWay:(NSString*)sender;

@end

@interface YfeedBackTwoCell : BaseTableViewCell

@property (strong,nonatomic) UITextField *connectTF;

@property (weak,nonatomic) id<YfeedBackTwoCellDelegate>delegate;

@end
