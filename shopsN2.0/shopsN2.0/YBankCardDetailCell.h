//
//  YBankCardDetailCell.h
//  shopsN
//
//  Created by imac on 2016/12/24.
//  Copyright © 2016年 联系QQ:1084356436. All rights reserved.
//

#import "BaseTableViewCell.h"

@protocol YBankCardDetailCellDelegate <NSObject>

-(void)getInputTFdetail:(NSString *)text index:(NSInteger)tag;

@end

@interface YBankCardDetailCell : BaseTableViewCell

@property (strong,nonatomic) NSString *title;

@property (strong,nonatomic) NSString *plachorText;

@property (strong,nonatomic) NSString *detail;

@property (weak,nonatomic) id<YBankCardDetailCellDelegate>delegate;

@end
