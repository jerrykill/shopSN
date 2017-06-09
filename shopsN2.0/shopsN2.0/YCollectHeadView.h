//
//  YCollectHeadView.h
//  shopsN
//
//  Created by imac on 2016/12/31.
//  Copyright © 2016年 联系QQ:1084356436. All rights reserved.
//

#import "BaseView.h"
#import "YGoodClassModel.h"

@protocol YCollectHeadViewDelegate <NSObject>

-(void)getCollectType:(YGoodClassModel*)text;

@end

@interface YCollectHeadView : BaseView

@property (strong,nonatomic) NSMutableArray<YGoodClassModel*> *dataArr;

@property (weak,nonatomic) id<YCollectHeadViewDelegate>delegate;

@end
