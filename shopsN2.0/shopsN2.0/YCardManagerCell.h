//
//  YCardManagerCell.h
//  shopsN
//
//  Created by imac on 2017/1/11.
//  Copyright © 2017年 联系QQ:1084356436. All rights reserved.
//

#import "BaseTableViewCell.h"

@protocol YCardManagerCellDelegate <NSObject>

-(void)cardManager:(NSInteger)sender index:(NSInteger)tag;

@end

@interface YCardManagerCell : BaseTableViewCell

@property (strong,nonatomic) NSString *name;

@property (strong,nonatomic) NSString *num;

@property (weak,nonatomic) id<YCardManagerCellDelegate>delegate;

@end
