//
//  YEvaluteOrderCell.h
//  shopsN
//
//  Created by imac on 2016/12/8.
//  Copyright © 2016年 联系QQ:1084356436. All rights reserved.
//

#import "BaseTableViewCell.h"
#import "YOrderEvalueModel.h"


@protocol YEvaluteOrderCellDelegate <NSObject>

-(void)addPhotos:(NSInteger)tag;

-(void)giveStar:(NSInteger)star index:(NSInteger)tag;

-(void)evaluteText:(NSString *)string index:(NSInteger)tag;

@end

@interface YEvaluteOrderCell : BaseTableViewCell

@property (weak,nonatomic) id<YEvaluteOrderCellDelegate>delegate;

@property (strong,nonatomic) YOrderEvalueModel *model;

@end
