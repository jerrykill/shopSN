//
//  YConsDetailPutView.h
//  shopsN
//
//  Created by imac on 2016/12/30.
//  Copyright © 2016年 联系QQ:1084356436. All rights reserved.
//

#import "BaseView.h"

@protocol YConsDetailPutViewDelegate <NSObject>

-(void)getConsInfo:(NSString *)detail;

@end

@interface YConsDetailPutView : BaseView

@property (strong,nonatomic) NSString *title;

@property (weak,nonatomic) id<YConsDetailPutViewDelegate>delegate;

@end
