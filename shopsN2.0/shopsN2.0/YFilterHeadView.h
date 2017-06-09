//
//  YFilterHeadView.h
//  shopsN
//
//  Created by imac on 2017/1/16.
//  Copyright © 2017年 联系QQ:1084356436. All rights reserved.
//

#import "BaseView.h"

@protocol YFilterHeadViewDelegate <NSObject>

- (void)lookMore;

- (void)makeBack;

- (void)searchDid:(NSString*)text;

- (void)searchBegin;

@end

@interface YFilterHeadView : BaseView

@property (assign,nonatomic) BOOL isEdit;

@property (strong,nonatomic) NSString *title;

@property (weak,nonatomic) id<YFilterHeadViewDelegate>delegate;

@property (strong,nonatomic) UITextField *searchTF;

@end
