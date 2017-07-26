//
//  YQueryPhoneCell.h
//  shopsN
//
//  Created by imac on 2017/1/5.
//  Copyright © 2017年 联系QQ:1084356436. All rights reserved.
//

#import "BaseTableViewCell.h"

@protocol YQueryPhoneCellDelegate <NSObject>

-(void)makePhone;

@end

@interface YQueryPhoneCell : BaseTableViewCell

@property (weak,nonatomic) id<YQueryPhoneCellDelegate>delegate;

@end
