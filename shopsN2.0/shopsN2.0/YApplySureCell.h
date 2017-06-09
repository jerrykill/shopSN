//
//  YApplySureCell.h
//  shopsN
//
//  Created by imac on 2017/3/30.
//  Copyright © 2017年 联系QQ:1084356436. All rights reserved.
//

#import "BaseTableViewCell.h"

@protocol YApplySureCellDelegate <NSObject>

- (void)chooseApply;

@end

@interface YApplySureCell : BaseTableViewCell

@property (weak,nonatomic) id<YApplySureCellDelegate>delegate;

@end
