//
//  YGoodClassModel.h
//  shopsN
//
//  Created by imac on 2016/11/23.
//  Copyright © 2016年 联系QQ:1084356436. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface YGoodClassModel : NSObject
/**商品分类标题*/
@property (strong,nonatomic) NSString *classTitle;
/**商品分类介绍*/
@property (strong,nonatomic) NSString *classdesc;

/**商品分类图标名*/
@property (strong,nonatomic) NSString *imageName;
/**分类id*/
@property (strong,nonatomic) NSString *classID;

@end
