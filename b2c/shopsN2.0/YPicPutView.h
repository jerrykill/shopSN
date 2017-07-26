//
//  YPicPutView.h
//  shopsN
//
//  Created by imac on 2016/12/24.
//  Copyright © 2016年 联系QQ:1084356436. All rights reserved.
//

#import "BaseView.h"

@protocol YPicPutViewDelegate <NSObject>

-(void)addPhoto;

-(void)deleteImgIndex:(NSInteger)index;

@end


@interface YPicPutView : BaseView

@property (strong,nonatomic) NSMutableArray *imageArr;

@property (weak,nonatomic) id<YPicPutViewDelegate>delegate;

@end
