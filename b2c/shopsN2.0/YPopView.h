//
//  YPopView.h
//  shopsN
//  气泡view
//  Created by imac on 2016/12/1.
//  Copyright © 2016年 联系QQ:1084356436. All rights reserved.
//

#import "BaseView.h"

@protocol YPopViewDelegate <NSObject>

-(void)chooseIndex:(NSInteger)index;

@end

@interface YPopView : BaseView

@property (weak,nonatomic) id<YPopViewDelegate>delegate;

-(instancetype)initWithFrame:(CGRect)frame
              title:(NSArray *)titleList
              image:(NSArray *)images;

-(void)hidden;


@end

