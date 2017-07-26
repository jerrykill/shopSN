//
//  YGiftAreaPickerView.h
//  shopsN
//
//  Created by imac on 2017/1/7.
//  Copyright © 2017年 联系QQ:1084356436. All rights reserved.
//

#import "BaseView.h"

@protocol YGiftAreaPickerViewDelegate <NSObject>

- (void)chooseIntegral:(NSString *)text;

@end

@interface YGiftAreaPickerView : BaseView

@property (strong,nonatomic) NSArray *listArr;

@property (weak,nonatomic) id<YGiftAreaPickerViewDelegate>delegate;

@end
