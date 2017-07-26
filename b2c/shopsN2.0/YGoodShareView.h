//
//  YGoodShareView.h
//  shopsN
//
//  Created by imac on 2016/12/16.
//  Copyright © 2016年 联系QQ:1084356436. All rights reserved.
//

#import "BaseView.h"

@protocol YGoodShareViewDelegate <NSObject>

-(void)shareType:(NSInteger)sender Url:(NSString*)goodID;

@end

@interface YGoodShareView : BaseView

@property (strong,nonatomic) NSString *goodID;

@property (weak,nonatomic) id<YGoodShareViewDelegate>delegate;

@end
