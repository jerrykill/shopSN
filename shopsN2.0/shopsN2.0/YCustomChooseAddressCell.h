//
//  YCustomChooseAddressCell.h
//  shopsN
//
//  Created by imac on 2017/3/31.
//  Copyright © 2017年 联系QQ:1084356436. All rights reserved.
//

#import "BaseTableViewCell.h"

@protocol YCustomChooseAddressCellDelegate <NSObject>

- (void)chooseAddress;

@end

@interface YCustomChooseAddressCell : BaseTableViewCell

@property (strong,nonatomic) NSString *address;

@property (weak,nonatomic) id<YCustomChooseAddressCellDelegate>delegate;

@end
