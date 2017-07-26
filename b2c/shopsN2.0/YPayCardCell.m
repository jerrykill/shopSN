//
//  YPayCardCell.m
//  shopsN
//
//  Created by imac on 2016/12/23.
//  Copyright © 2016年 联系QQ:1084356436. All rights reserved.
//

#import "YPayCardCell.h"

@interface YPayCardCell ()

@property (strong,nonatomic) UIImageView *headIV;

@property (strong,nonatomic) UILabel *titleLb;

@property (strong,nonatomic) UILabel *detailLb;

@end

@implementation YPayCardCell

-(instancetype)initWithStyle:(UITableViewCellStyle)style reuseIdentifier:(NSString *)reuseIdentifier{
    if (self = [super initWithStyle:style reuseIdentifier:reuseIdentifier]) {
        self.selectionStyle = UITableViewCellSelectionStyleNone;
        self.backgroundColor = [UIColor whiteColor];
        [self initView];
    }
    return self;
}

- (void)initView{
    _headIV = [[UIImageView alloc]initWithFrame:CGRectMake(10, 22, 43, 32)];
    [self addSubview:_headIV];
    _headIV.image = MImage(@"Bank_card");

    _titleLb = [[UILabel alloc]initWithFrame:CGRectMake(CGRectXW(_headIV)+23, 15,130, 20)];
    [self addSubview:_titleLb];
    _titleLb.textAlignment = NSTextAlignmentLeft;
    _titleLb.textColor = __DTextColor;
    _titleLb.font = MFont(17);

    _detailLb = [[UILabel alloc]initWithFrame:CGRectMake(CGRectXW(_headIV)+23, CGRectYH(_titleLb)+14, 120, 15)];
    [self addSubview:_detailLb];
    _detailLb.textAlignment = NSTextAlignmentLeft;
    _detailLb.textColor = __DTextColor;
    _detailLb.font= MFont(14);

    UIButton *logoBtn = [[UIButton alloc]initWithFrame:CGRectMake(__kWidth-24-15, 33, 24, 14)];
    [self addSubview:logoBtn];
    [logoBtn setImage:MImage(@"under_arrow") forState:BtnNormal];
    [logoBtn addTarget:self action:@selector(choosesCard) forControlEvents:BtnTouchUpInside];

    UIImageView *lineIV = [[UIImageView alloc]initWithFrame:CGRectMake(0, 79, __kWidth, 1)];
    [self addSubview:lineIV];
    lineIV.backgroundColor = __BackColor;


}

-(void)choosesCard{
    [self.delegate chooseCard];
}

-(void)setTitle:(NSString *)title{
    _title = title;
    _titleLb.text = title;
}

-(void)setImageName:(NSString *)imageName{
//    _headIV.image = MImage(imageName);
}

-(void)setDetail:(NSString *)detail{
    _detailLb.text = detail;
}

@end
