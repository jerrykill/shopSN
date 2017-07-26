//
//  YtabBarButton.h
//  shopsN
//
//  Created by imac on 2016/11/23.
//  Copyright © 2016年 联系QQ:1084356436. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface YtabBarButton : UIButton
@property (strong,nonatomic) UIImageView *colorIV;

- (void)addBtnImage:(UIImage*)image SelectedImage:(UIImage*)selectedImage
             title:(NSString*)name;

@end
