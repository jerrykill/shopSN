//
//  YChooseConsCell.h
//  shopsN
//
//  Created by imac on 2016/12/30.
//  Copyright © 2016年 联系QQ:1084356436. All rights reserved.
//

#import "BaseTableViewCell.h"
#import "YAddConsModel.h"

@protocol YChooseConsCellDelegate <NSObject>

-(void)consCellCancel:(NSInteger)tag;

@end

@interface YChooseConsCell : BaseTableViewCell

@property (strong,nonatomic) YConsModel *model;

@property (weak,nonatomic) id<YChooseConsCellDelegate>delegate;

@end
