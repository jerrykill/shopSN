//
//  YApplySalesSureCell.h
//  shopsN
//
//  Created by imac on 2017/1/5.
//  Copyright © 2017年 联系QQ:1084356436. All rights reserved.
//

#import "BaseTableViewCell.h"

@protocol YApplySalesSureCellDelegate <NSObject>

-(void)makeAppply;

@end

@interface YApplySalesSureCell : BaseTableViewCell

@property (weak,nonatomic) id<YApplySalesSureCellDelegate>delegate;

@end
