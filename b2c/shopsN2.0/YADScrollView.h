//
//  YADScrollView.h
//  shopsN
//
//  Created by imac on 2016/11/25.
//  Copyright © 2016年 联系QQ:1084356436. All rights reserved.
//

#import "BaseView.h"
#import "YHeadImage.h"

@protocol YADScrollViewDelegate <NSObject>

-(void)chooseAD:(NSString *)url;

@end

@interface YADScrollView : BaseView

@property (strong,nonatomic) NSArray<YHeadImage*> *imgArr;

@property (strong,nonatomic) id<YADScrollViewDelegate>delegate;

@end
