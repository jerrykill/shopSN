//
//  YPromotionClassModel.h
//  shopsN
//
//  Created by imac on 2016/12/12.
//  Copyright © 2016年 联系QQ:1084356436. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface YPromotionClassModel : NSObject

@property (strong,nonatomic) NSString *classId;

@property (strong,nonatomic) NSString *className;

@property (strong,nonatomic) NSString *englishclass;

@property (strong,nonatomic) NSString *classUrl;

@property (strong,nonatomic) NSArray<NSString *> *tagArr;

@end
