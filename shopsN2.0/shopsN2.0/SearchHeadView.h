//
//  SearchHeadView.h
//  shopsN
//
//  Created by imac on 2016/11/28.
//  Copyright © 2016年 联系QQ:1084356436. All rights reserved.
//

#import <UIKit/UIKit.h>

@protocol SearchHeadViewDelegate <NSObject>

-(void)lookMessage;

- (void)searchDid:(NSString *)text;

- (void)searchBegin;
@end

@interface SearchHeadView : UIView

@property (assign,nonatomic) BOOL isEdit;

@property (weak,nonatomic) id<SearchHeadViewDelegate>delegate;

@property (strong,nonatomic) UIButton *messageBtn;

@property (strong,nonatomic) NSString *title;

@end
