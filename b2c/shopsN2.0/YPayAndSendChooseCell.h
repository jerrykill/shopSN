//
//  YPayAndSendChooseCell.h
//  shopsN
//
//  Created by imac on 2016/12/21.
//  Copyright © 2016年 联系QQ:1084356436. All rights reserved.
//

#import "BaseTableViewCell.h"

@protocol YPayAndSendChooseCellDelegate <NSObject>

-(void)chooseType:(NSString *)sender index:(NSInteger)index;

@end

@interface YPayAndSendChooseCell : BaseTableViewCell

@property (strong,nonatomic) NSString *firstChoose;

@property (strong,nonatomic) NSString *secondChoose;

@property (assign,nonatomic) NSUInteger choose;

@property (strong,nonatomic) NSMutableArray <YServiceTitleModel*>*chooseList;


@property (weak,nonatomic) id<YPayAndSendChooseCellDelegate>delegate;

@end
