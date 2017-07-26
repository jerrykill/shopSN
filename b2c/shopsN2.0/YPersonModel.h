//
//  YPersonModel.h
//  shopsN
//
//  Created by imac on 2017/1/12.
//  Copyright © 2017年 联系QQ:1084356436. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface YPersonModel : NSObject
/**头像*/
@property (strong,nonatomic) NSString *imageName;
/**用户名*/
@property (strong,nonatomic) NSString *name;
/**昵称*/
@property (strong,nonatomic) NSString *nickName;
/**邮箱*/
@property (strong,nonatomic) NSString *email;
/**性别*/
@property (strong,nonatomic) NSString *sex;
/**联系电话*/
@property (strong,nonatomic) NSString *phone;
/**生日*/
@property (strong,nonatomic) NSString *birth;
/**职位*/
@property (strong,nonatomic) NSString *job;

@end
