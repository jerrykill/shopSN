//
//  YADwarnView.h
//  shopsN
//
//  Created by imac on 2016/11/23.
//  Copyright © 2016年 联系QQ:1084356436. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "YWarnModel.h"

@protocol YADwarnViewDelegate <NSObject>

-(void)getMore;

-(void)chooseWarn:(NSInteger)index;

@end

@interface YADwarnView : UICollectionReusableView

//@property (strong,nonatomic) NSString *notice;

@property (strong,nonatomic) NSArray<YWarnModel*> *titleArr;

@property (weak,nonatomic) id<YADwarnViewDelegate>delegate;

@end
