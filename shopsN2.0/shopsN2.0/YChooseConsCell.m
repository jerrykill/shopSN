//
//  YChooseConsCell.m
//  shopsN
//
//  Created by imac on 2016/12/30.
//  Copyright © 2016年 联系QQ:1084356436. All rights reserved.
//

#import "YChooseConsCell.h"

@interface YChooseConsCell ()

@property (strong,nonatomic) UILabel *warnLb;

@property (strong,nonatomic) UIView *backV;

@property (strong,nonatomic) UILabel *titleLb;

@property (strong,nonatomic) UIButton *cancelBtn;

@end

@implementation YChooseConsCell

-(instancetype)initWithStyle:(UITableViewCellStyle)style reuseIdentifier:(NSString *)reuseIdentifier{
    if (self = [super initWithStyle:style reuseIdentifier:reuseIdentifier]) {
        self.selectionStyle = UITableViewCellSelectionStyleNone;
        self.backgroundColor= __BackColor;
        [self initView];
    }
    return self;
}

-(void)initView{
    [self addSubview:self.warnLb];
    [self addSubview:self.backV];
    [_backV addSubview:self.titleLb];
    [_backV addSubview:self.cancelBtn];

}

#pragma mark ==懒加载==
-(UILabel *)warnLb{
    if (!_warnLb) {
        _warnLb = [[UILabel alloc]initWithFrame:CGRectMake(15, 16, 80, 20)];
        _warnLb.textAlignment = NSTextAlignmentLeft;
        _warnLb.textColor = LH_RGBCOLOR(150, 150, 150);
        _warnLb.font =MFont(16);
        _warnLb.text = @"已选耗材：";
    }
    return _warnLb;
}

-(UIView *)backV{
    if (!_backV) {
        _backV = [[UIView alloc]initWithFrame:CGRectMake(CGRectXW(_warnLb), 13, __kWidth-110, 25)];
        _backV.backgroundColor = [UIColor whiteColor];
        _backV.layer.cornerRadius = 5;
        _backV.hidden = YES;
    }
    return _backV;
}

-(UILabel *)titleLb{
    if (!_titleLb) {
        _titleLb = [[UILabel alloc]initWithFrame:CGRectMake(15, 4, CGRectW(_backV)-45, 15)];
        _titleLb.textAlignment = NSTextAlignmentLeft;
        _titleLb.textColor = __DTextColor;
        _titleLb.font = MFont(14);
        _titleLb.numberOfLines =0;
    }
    return _titleLb;
}

-(UIButton *)cancelBtn{
    if (!_cancelBtn) {
        _cancelBtn = [[UIButton alloc]initWithFrame:CGRectMake(CGRectXW(_titleLb)+10, 5, 15, 15)];
        [_cancelBtn setImage:MImage(@"close") forState:BtnNormal];
        [_cancelBtn addTarget:self action:@selector(closeAction) forControlEvents:BtnTouchUpInside];
    }
    return _cancelBtn;
}

-(void)setModel:(YConsModel *)model{
    _backV.hidden = NO;
    NSString *str = [NSString stringWithFormat:@"%@,%@",model.title,model.num];
    CGSize size  =[str boundingRectWithSize:CGSizeMake(__kWidth-155, MAXFLOAT) options:NSStringDrawingUsesLineFragmentOrigin attributes:@{NSFontAttributeName:MFont(14)} context:nil].size;
    if (size.height>20) {
        _backV.frame = CGRectMake(CGRectXW(_warnLb), 13, __kWidth-110, size.height+10);
        _titleLb.frame = CGRectMake(15, 4, __kWidth-155, size.height);
    }else{
        _backV.frame = CGRectMake(CGRectXW(_warnLb), 13, size.width+45, 25);
        _titleLb.frame = CGRectMake(15, 4, size.width, 15);
        _cancelBtn.frame = CGRectMake(CGRectXW(_titleLb)+10, 5, 15, 15);
    }
    _titleLb.text = str;
    if (self.tag) {
        _warnLb.hidden = YES;
    }
}

-(void)closeAction{
    [self.delegate consCellCancel:self.tag];
}

@end
