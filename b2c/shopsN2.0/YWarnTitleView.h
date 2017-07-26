//
//  YWarnTitleView.h
//  shopsN
//
//  Created by imac on 2017/2/21.
//  Copyright © 2017年 联系QQ:1084356436. All rights reserved.
//

#import "BaseView.h"
#import "YWarnModel.h"

@protocol YWarnTitleViewDelegate <NSObject>

-(void)chooseWarnTitle:(NSInteger)index;

@end

@interface YWarnTitleView : BaseView

@property (strong,nonatomic) NSArray<YWarnModel*> *titleArr;

@property (weak,nonatomic) id<YWarnTitleViewDelegate>delegate;

@end
