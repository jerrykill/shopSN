//
//  YBuyingOrderDateCell.m
//  shopsN
//
//  Created by imac on 2016/12/28.
//  Copyright © 2016年 联系QQ:1084356436. All rights reserved.
//

#import "YBuyingOrderDateCell.h"

@interface YBuyingOrderDateCell ()<UITextFieldDelegate>

@property (strong,nonatomic) UILabel *titleLb;

@property (strong,nonatomic) UITextField *detailTF;

@property (strong,nonatomic) UIImageView *dataIV;
@end

@implementation YBuyingOrderDateCell

-(instancetype)initWithStyle:(UITableViewCellStyle)style reuseIdentifier:(NSString *)reuseIdentifier{
    if (self = [super initWithStyle:style reuseIdentifier:reuseIdentifier]) {
        self.selectionStyle = UITableViewCellSelectionStyleNone;
        self.backgroundColor = [UIColor whiteColor];
        [self initView];
    }
    return self;
}

-(void)initView{
    [self addSubview:self.titleLb];
    [self addSubview:self.detailTF];
    [self addSubview:self.dataIV];
}

#pragma mark ==懒加载==
-(UILabel *)titleLb{
    if (!_titleLb) {
        _titleLb =[[UILabel alloc]initWithFrame:CGRectMake(10, 15, 80, 15)];
        _titleLb.textAlignment = NSTextAlignmentLeft;
        _titleLb.textColor = __DTextColor;
        _titleLb.font = MFont(15);
        _titleLb.text = @"收货日期：";
    }
    return _titleLb;
}

-(UITextField *)detailTF{
    if (!_detailTF) {
        _detailTF = [[UITextField alloc]initWithFrame:CGRectMake(CGRectXW(_titleLb), 16, __kWidth-135, 14)];
        _detailTF.textColor =  __DTextColor;
        _detailTF.font = MFont(13);
        _detailTF.textAlignment = NSTextAlignmentRight;
        _detailTF.placeholder = @"不填写则默认发货时间";
        _detailTF.delegate =self;
    }
    return _detailTF;
}

-(UIImageView *)dataIV{
    if (!_dataIV) {
        _dataIV = [[UIImageView alloc]initWithFrame:CGRectMake(CGRectXW(_detailTF)+10, 12, 18, 18)];
        _dataIV.image = MImage(@"purchase_date");
    }
    return _dataIV;
}

-(void)setDate:(NSString *)date{
    NSDateFormatter *formatter =[[NSDateFormatter alloc]init];
    [formatter setDateFormat:@"yyyy-MM-dd"];
    NSDate *coms = [NSDate dateWithTimeIntervalSince1970:[date integerValue]];
    NSString *dates =[formatter stringFromDate:coms];
    _detailTF.text = [NSString stringWithFormat:@"%@",dates];

}

#pragma mark ==UITextFiledDelegate==
-(BOOL)textFieldShouldBeginEditing:(UITextField *)textField{
    [self.delegate changeFramed];
    return NO;
}

@end
