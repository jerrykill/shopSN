//
//  YHeadImage.h
//  shopsN
//
//  Created by imac on 2016/11/22.
//  Copyright © 2016年 联系QQ:1084356436. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface YHeadImage : NSObject
/**图片id*/
@property (strong,nonatomic) NSString *imageID;
/**图片url*/
@property (strong,nonatomic) NSString *imageName;
/**链接地址*/
@property (strong,nonatomic) NSString *imageUrl;
/**类型*/
@property (strong,nonatomic) NSString *type;
@end
