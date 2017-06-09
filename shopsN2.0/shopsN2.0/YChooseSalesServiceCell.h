//
//  YChooseSalesServiceCell.h
//  shopsN
//
//  Created by imac on 2017/1/4.
//  Copyright © 2017年 联系QQ:1084356436. All rights reserved.
//

#import "BaseTableViewCell.h"

@protocol YChooseSalesServiceCellDelegate <NSObject>

-(void)chooseServiceType:(NSInteger)sender;

@end

@interface YChooseSalesServiceCell : BaseTableViewCell

@property (weak,nonatomic) id<YChooseSalesServiceCellDelegate>delegate;

@end
