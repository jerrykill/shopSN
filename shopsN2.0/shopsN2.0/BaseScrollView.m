//
//  BaseScrollView.m
//  shopSN
//
//  Created by imac on 15/12/10.
//  Copyright © 2015年 imac. All rights reserved.
//

#import "BaseScrollView.h"

@implementation BaseScrollView

/*
// Only override drawRect: if you perform custom drawing.
// An empty implementation adversely affects performance during animation.
- (void)drawRect:(CGRect)rect {
    // Drawing code
}
*/
-(instancetype)initWithFrame:(CGRect)frame{
    self=[super initWithFrame:frame];
    if (self) {
        self.backgroundColor=HEXCOLOR(0xffffff);
    }
    return self;
}
@end
