//
//  YReturnsNumCell.h
//  shopsN
//
//  Created by imac on 2017/1/5.
//  Copyright © 2017年 联系QQ:1084356436. All rights reserved.
//

#import "BaseTableViewCell.h"

@protocol YReturnsNumCellDelegate <NSObject>

-(void)changeApplyNum:(BOOL)sender;

@end

@interface YReturnsNumCell : BaseTableViewCell

@property (strong,nonatomic) NSString *count;

@property (weak,nonatomic) id<YReturnsNumCellDelegate>delegate;

@end
