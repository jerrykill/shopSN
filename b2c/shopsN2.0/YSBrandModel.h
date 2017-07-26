//
//  YSBrandModel.h
//  shopsN2.0
//
//  Created by imac on 2017/7/5.
//  Copyright © 2017年 联系QQ:1084356436. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface YSBrandModel : NSObject
/**id*/
@property (strong,nonatomic) NSString *brandId;
/**图片名*/
@property (strong,nonatomic) NSString *imageName;
/**品牌名*/
@property (strong,nonatomic) NSString *name;
/**logo*/
@property (strong,nonatomic) NSString *logo;
/**全名*/
@property (strong,nonatomic) NSString *detailName;
/**介绍*/
@property (strong,nonatomic) NSString *info;
@end


