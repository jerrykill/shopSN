//
//  YPlistChooseAreaView.h
//  shopsN
//
//  Created by imac on 2017/3/16.
//  Copyright © 2017年 联系QQ:1084356436. All rights reserved.
//

#import "BaseView.h"
#import "YPlistAddressModel.h"

@protocol YPlistChooseAreaViewDelegate <NSObject>

-(void)chooseAddressData:(YPlistAddressModel*)data;

@end

@interface YPlistChooseAreaView : BaseView
/**
 *  省
 */
@property (strong,nonatomic) NSString *province;
/**
 *  市
 */
@property (strong,nonatomic) NSString *city;
/**
 *  区
 */
@property (strong,nonatomic) NSString *area;

-(instancetype)initWithAreaFrame:(CGRect)frame;

@property (weak,nonatomic) id<YPlistChooseAreaViewDelegate>delegate;

@end
