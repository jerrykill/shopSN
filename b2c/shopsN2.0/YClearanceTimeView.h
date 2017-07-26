//
//  YClearanceTimeView.h
//  shopsN
//
//  Created by imac on 2016/12/9.
//  Copyright © 2016年 联系QQ:1084356436. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "YHeadImage.h"

@protocol YClearanceTimeViewDelegate <NSObject>

-(void)chooseAD:(NSString*)url;

@end

@interface YClearanceTimeView : UICollectionReusableView

@property (strong,nonatomic) NSMutableArray<YHeadImage*>*imageArr;


@property (strong,nonatomic) NSString *time;

@property (weak,nonatomic) id<YClearanceTimeViewDelegate>delegate;

@end
