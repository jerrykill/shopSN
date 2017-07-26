//
//  YSectionBottomView.h
//  shopsN
//
//  Created by imac on 2016/11/25.
//  Copyright © 2016年 联系QQ:1084356436. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "YHeadImage.h"

@protocol YSectionBottomViewDelegate <NSObject>

-(void)chooseBottomV:(NSString *)url;

@end

@interface YSectionBottomView : UICollectionReusableView

@property (strong,nonatomic) NSArray<YHeadImage*> *imageArr;

@property (weak,nonatomic) id<YSectionBottomViewDelegate>delegate;

@end
