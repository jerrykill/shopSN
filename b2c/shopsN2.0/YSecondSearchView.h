//
//  YSecondSearchView.h
//  shopsN
//
//  Created by imac on 2016/12/8.
//  Copyright © 2016年 联系QQ:1084356436. All rights reserved.
//

#import "BaseView.h"

@protocol YSecondSearchViewDelegate <NSObject>

-(void)search:(NSString *)sender;

- (void)chooseRight;

- (void)chooseNaviback;

@end

@interface YSecondSearchView : BaseView

@property (weak,nonatomic) id<YSecondSearchViewDelegate>delegate;

@end
