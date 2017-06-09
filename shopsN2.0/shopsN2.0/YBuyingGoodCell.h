//
//  YBuyingGoodCell.h
//  shopsN
//
//  Created by imac on 2016/12/28.
//  Copyright © 2016年 联系QQ:1084356436. All rights reserved.
//

#import "BaseTableViewCell.h"

@protocol YBuyingGoodCellDelegate <NSObject>

-(void)getDetailtext:(NSString *)sender Index:(NSInteger)tag;

-(void)choosedata;

@end

@interface YBuyingGoodCell : BaseTableViewCell

@property (strong,nonatomic) NSString *title;

@property (strong,nonatomic) NSString *detail;

@property (nonatomic) BOOL isMoney;

@property (weak,nonatomic) id<YBuyingGoodCellDelegate>delegate;

@end
