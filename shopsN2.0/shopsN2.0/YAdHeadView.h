//
//  YAdHeadView.h
//  shopsN
//
//  Created by imac on 2016/11/23.
//  Copyright © 2016年 联系QQ:1084356436. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "YHeadImage.h"

@protocol YAdHeadViewDelegate <NSObject>

-(void)chooseAD:(NSString *)url;

@end

@interface YAdHeadView : UICollectionReusableView

@property (strong,nonatomic) NSArray<YHeadImage*> *dataArr;

@property (weak,nonatomic) id<YAdHeadViewDelegate>delegate;

@end
