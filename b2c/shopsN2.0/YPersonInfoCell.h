//
//  YPersonInfoCell.h
//  shopsN
//
//  Created by imac on 2017/1/12.
//  Copyright © 2017年 联系QQ:1084356436. All rights reserved.
//

#import "BaseTableViewCell.h"

@protocol YPersonInfoCellDelegate <NSObject>

-(void)changePersonInfo:(NSString *)sender index:(NSInteger)index;


@end

@interface YPersonInfoCell : BaseTableViewCell

@property (strong,nonatomic) NSString *title;

@property (strong,nonatomic) NSString *detail;

@property (weak,nonatomic) id<YPersonInfoCellDelegate>delegate;

@end
