//
//  YSearchPushView.h
//  shopsN
//
//  Created by imac on 2016/12/1.
//  Copyright © 2016年 联系QQ:1084356436. All rights reserved.
//

#import "BaseView.h"

@protocol YSearchPushViewDelegate <NSObject>


-(void)chooseBack;

-(void)searchDid:(NSString *)text;

@end

@interface YSearchPushView : BaseView

@property (weak,nonatomic) id<YSearchPushViewDelegate>delegate;

@property (strong,nonatomic) UITextField *searchTF;

@end
