//
//  YCuponTypeChooseView.h
//  shopsN
//
//  Created by imac on 2016/12/27.
//  Copyright © 2016年 联系QQ:1084356436. All rights reserved.
//

#import "BaseView.h"

@protocol YCuponTypeChooseViewDelegate <NSObject>

-(void)chooseCuponType:(NSInteger)sender;

@end

@interface YCuponTypeChooseView : BaseView

@property (strong,nonatomic) NSArray *titleArr;

@property (weak,nonatomic) id<YCuponTypeChooseViewDelegate>delegate;

@end
