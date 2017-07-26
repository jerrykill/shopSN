//
//  YSBrandListModel.h
//  shopsN2.0
//
//  Created by imac on 2017/7/10.
//  Copyright © 2017年 联系QQ:1084356436. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "YSBrandModel.h"

@interface YSBrandListModel : NSObject

@property (strong,nonatomic) NSString *sectionName;

@property (strong,nonatomic) NSMutableArray <YSBrandModel*>*list;

@end
