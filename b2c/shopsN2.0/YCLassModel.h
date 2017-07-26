//
//  YCLassModel.h
//  shopsN
//
//  Created by imac on 2016/11/29.
//  Copyright © 2016年 联系QQ:1084356436. All rights reserved.
//

#import <Foundation/Foundation.h>

@class YClassTwoModel,YClassThreeModel;

@interface YCLassModel : NSObject
//主类名
@property (strong,nonatomic) NSString *className;

@property (strong,nonatomic) NSString *classId;

@property (strong,nonatomic) NSString *fid;

@property (strong,nonatomic) NSMutableArray<YClassTwoModel *>* List;

@end

@interface YClassTwoModel : NSObject
//二级类名
@property (strong,nonatomic) NSString *sectionName;

@property (strong,nonatomic) NSString *classId;

@property (strong,nonatomic) NSMutableArray<YClassThreeModel*>* array;

@end
@interface YClassThreeModel : NSObject
//三级图标
@property (strong,nonatomic) NSString *imageName;
//三级类名
@property (strong,nonatomic) NSString *title;

@property (strong,nonatomic) NSString *classId;

@end
