//
//  YBuyingChooseCell.h
//  shopsN
//
//  Created by imac on 2016/12/28.
//  Copyright © 2016年 联系QQ:1084356436. All rights reserved.
//

#import "BaseTableViewCell.h"

@protocol YBuyingChooseCellDelegate <NSObject>

-(void)chooseType:(NSString *)type index:(NSInteger)tag;

@end

@interface YBuyingChooseCell : BaseTableViewCell

@property (strong,nonatomic) NSArray *chooseArr;

@property (strong,nonatomic) NSString *title;

@property (strong,nonatomic) NSString *choose;

@property (weak,nonatomic) id<YBuyingChooseCellDelegate>delegate;

@end
