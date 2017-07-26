//
//  YSCLassLeftView.h
//  shopsN
//
//  Created by imac on 2017/4/28.
//  Copyright © 2017年 联系QQ:1084356436. All rights reserved.
//

#import "BaseView.h"
#import "YCLassModel.h"

@protocol YSCLassLeftViewDelegate <NSObject>

- (void)chooseClassOne:(NSString*)classId;

@end

@interface YSCLassLeftView : BaseView

@property (strong,nonatomic) NSArray <YCLassModel*>*dataArr;

@property (weak,nonatomic) id<YSCLassLeftViewDelegate>delegate;

@end
