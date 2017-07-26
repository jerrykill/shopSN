//
//  YSMessageModel.h
//  shopsN2.0
//
//  Created by imac on 2017/5/31.
//  Copyright © 2017年 联系QQ:1084356436. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface YSMessageModel : NSObject
/**消息id*/
@property (strong,nonatomic) NSString *newsId;
/**消息标题*/
@property (strong,nonatomic) NSString *title;
/**消息时间戳*/
@property (strong,nonatomic) NSString *time;
/**消息内容*/
@property (strong,nonatomic) NSString *content;
/**图片*/
@property (strong,nonatomic) NSString *imageName;

@end
