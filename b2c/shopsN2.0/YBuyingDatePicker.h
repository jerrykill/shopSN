//
//  YBuyingDatePicker.h
//  shopsN
//
//  Created by imac on 2017/3/14.
//  Copyright © 2017年 联系QQ:1084356436. All rights reserved.
//

#import <UIKit/UIKit.h>

@protocol YBuyingDatePickerDelegate <NSObject>

-(void)chooseDateTime:(NSString*)sender;

- (void)hiddenView;

@end

@interface YBuyingDatePicker : BaseView

@property (weak,nonatomic) id<YBuyingDatePickerDelegate>delegate;

@end
