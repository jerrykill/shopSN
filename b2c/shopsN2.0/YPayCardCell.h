//
//  YPayCardCell.h
//  shopsN
//
//  Created by imac on 2016/12/23.
//  Copyright © 2016年 联系QQ:1084356436. All rights reserved.
//

#import "BaseTableViewCell.h"

@protocol YPayCardCellDelegate <NSObject>

-(void)chooseCard;

@end

@interface YPayCardCell : BaseTableViewCell

@property (strong,nonatomic) NSString *imageName;

@property (strong,nonatomic) NSString *title;

@property (strong,nonatomic) NSString *detail;

@property (weak,nonatomic) id<YPayCardCellDelegate>delegate;

@end
