//
//  YServiceAskModel.h
//  shopsN
//
//  Created by imac on 2017/1/4.
//  Copyright © 2017年 联系QQ:1084356436. All rights reserved.
//

#import <Foundation/Foundation.h>

@class YServiceTitleModel;
@interface YServiceAskModel : NSObject

@property (strong,nonatomic) NSString *className;

@property (strong,nonatomic) NSArray <YServiceTitleModel*>*titleArr;

@end

@interface YServiceTitleModel : NSObject
/**文章id*/
@property (strong,nonatomic) NSString *titleId;
/**文章标题*/
@property (strong,nonatomic) NSString *titleName;

@end
