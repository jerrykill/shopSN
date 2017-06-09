//
//  YCustomInfoCell.m
//  shopsN
//
//  Created by imac on 2017/3/31.
//  Copyright © 2017年 联系QQ:1084356436. All rights reserved.
//

#import "YCustomInfoCell.h"

@interface YCustomInfoCell ()

@property (strong,nonatomic) UILabel *warnLabel;

@end

@implementation YCustomInfoCell

- (instancetype)initWithStyle:(UITableViewCellStyle)style reuseIdentifier:(NSString *)reuseIdentifier{
    if (self = [super initWithStyle:style reuseIdentifier:reuseIdentifier]) {
        self.selectionStyle = UITableViewCellSelectionStyleNone;
        self.backgroundColor = __BackColor;
        [self initView];
    }
    return self;
}


- (void)initView{
    [self addSubview:self.warnLabel];
}

#pragma mark ==懒加载==
-(UILabel *)warnLabel{
    if (!_warnLabel) {
        _warnLabel = [[UILabel alloc]initWithFrame:CGRectMake(10, 15, __kWidth-20, 75)];
        _warnLabel.font = MFont(15);
        _warnLabel.numberOfLines = 0;
        _warnLabel.textAlignment = NSTextAlignmentLeft;
        NSMutableAttributedString *attr = [[NSMutableAttributedString alloc]initWithString:@"注:\n申请人须有营业执照、税务登记证、组织代码证、公司开票资料"];
        [attr addAttribute:NSForegroundColorAttributeName value:LH_RGBCOLOR(163, 163, 163) range:NSMakeRange(0, 2)];
        [attr addAttribute:NSForegroundColorAttributeName value:__DTextColor range:NSMakeRange(2, attr.length-2)];
        _warnLabel.attributedText = attr;

    }
    return _warnLabel;
}

@end
