//
//  YPersonSectionView.h
//  shopsN
//
//  Created by imac on 2016/12/2.
//  Copyright © 2016年 联系QQ:1084356436. All rights reserved.
//

#import "BaseView.h"

@protocol YPersonSectionViewDelegate <NSObject>

-(void)sureChange;

@end

@interface YPersonSectionView : BaseView

@property (weak,nonatomic) id<YPersonSectionViewDelegate>delegate;

@end
