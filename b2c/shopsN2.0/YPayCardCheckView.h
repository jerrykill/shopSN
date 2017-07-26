//
//  YPayCardCheckView.h
//  shopsN
//
//  Created by imac on 2016/12/23.
//  Copyright © 2016年 联系QQ:1084356436. All rights reserved.
//

#import "BaseView.h"

@protocol YPayCardCheckViewDelegate <NSObject>

- (void)chooseCheckAction:(NSString *)Cardid index:(NSInteger)index;

- (void)chooseAddNew;

@end

@interface YPayCardCheckView : BaseView

@property (strong,nonatomic) NSMutableArray *dataArr;


@property (weak,nonatomic) id<YPayCardCheckViewDelegate>delegate;

@end
