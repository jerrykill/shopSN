//
//  YCuponViewCell.m
//  shopsN
//
//  Created by imac on 2016/12/22.
//  Copyright © 2016年 联系QQ:1084356436. All rights reserved.
//

#import "YCuponViewCell.h"

@interface YCuponViewCell ()
//背景图
@property (strong,nonatomic) UIImageView *backIV;
//满限
@property (strong,nonatomic) UILabel *titleLb;
//不含运费
@property (strong,nonatomic) UILabel *notiLb;
//时间
@property (strong,nonatomic) UILabel *timeLb;
//金额
@property (strong,nonatomic) UILabel *moneyLb;
//立即使用
@property (strong,nonatomic) UIButton *useBtn;


@property (assign,nonatomic) BOOL  isOut;//过期
@end

@implementation YCuponViewCell

-(instancetype)initWithStyle:(UITableViewCellStyle)style reuseIdentifier:(NSString *)reuseIdentifier{
    if (self = [super initWithStyle:style reuseIdentifier:reuseIdentifier]) {
        self.backgroundColor = __BackColor;
        self.selectionStyle = UITableViewCellSelectionStyleNone;
        _isOut = NO;
        [self initView];
    }
    return self;
}

- (void)initView{
    _backIV = [[UIImageView alloc]initWithFrame:CGRectMake(6, 15, __kWidth-12, 100)];
    [self addSubview:_backIV];
//    _backIV.backgroundColor = LH_RandomColor;
    [self sendSubviewToBack:_backIV];

    _titleLb = [[UILabel alloc]initWithFrame:CGRectMake(20+6, 11+15, 200*__kWidth/375, 20)];
    [self addSubview:_titleLb];
    _titleLb.textAlignment = NSTextAlignmentLeft;
    _titleLb.font = MFont(18);

    _notiLb = [[UILabel alloc]initWithFrame:CGRectMake(26, CGRectYH(_titleLb)+4, 80, 15)];
    [self addSubview:_notiLb];
    _notiLb.textAlignment = NSTextAlignmentLeft;
    _notiLb.textColor = LH_RGBCOLOR(224, 40, 40);
    _notiLb.font =MFont(13);
    _notiLb.text = @"(不包含运费)";

    UILabel *useTimeLb = [[UILabel alloc]initWithFrame:CGRectMake(26, CGRectYH(_notiLb)+6, 80, 15)];
    [self addSubview:useTimeLb];
    useTimeLb.textAlignment = NSTextAlignmentLeft;
    useTimeLb.textColor = LH_RGBCOLOR(165, 165, 165);
    useTimeLb.font = MFont(11);
    useTimeLb.text = @"使用期限";

    _timeLb= [[UILabel alloc]initWithFrame:CGRectMake(26, CGRectYH(useTimeLb)+2, 200*__kWidth/375, 15)];
    [self addSubview:_timeLb];
    _timeLb.textAlignment = NSTextAlignmentLeft;
    _timeLb.textColor = LH_RGBCOLOR(117, 117, 117);
    _timeLb.font = MFont(11);

    _moneyLb = [[UILabel alloc]initWithFrame:CGRectMake(__kWidth-120, 18+15, 100, 20)];
    [self addSubview:_moneyLb];
    _moneyLb.textAlignment = NSTextAlignmentRight;
    _moneyLb.textColor = [UIColor whiteColor];

    _useBtn = [[UIButton alloc]initWithFrame:CGRectMake(__kWidth-90, CGRectYH(_moneyLb)+14, 64, 27)];
    [self addSubview:_useBtn];
    _useBtn.layer.cornerRadius = 4;
    _useBtn.titleLabel.font = MFont(12);
    _useBtn.layer.shadowOffset = CGSizeMake(2, 2);
    _useBtn.layer.shadowOpacity = 0.7;
    [_useBtn setTitle:@"立即使用" forState:BtnNormal];
    [_useBtn setTitleColor:[UIColor whiteColor] forState:BtnNormal];
    [_useBtn addTarget:self action:@selector(chooseUse) forControlEvents:BtnTouchUpInside];
}

-(void)chooseUse{
    [self.delegate chooseUseTag:self.tag];
}


-(void)setColor:(NSInteger)color{
    if (_isOut) {
        color = 4;
    }
    NSArray *imageArr = @[@"coupon_bg_01",@"coupon_bg_02",@"coupon_bg_03",@"coupon_bg_04"];
    if (color<3) {
        int x = arc4random() % 4;
        _backIV.image = MImage(imageArr[x]);
    }else{
        _backIV.image = MImage(@"coupon_bg_fail");
    }
    switch (color) {
        case 0:
        {
            _notiLb.textColor = LH_RGBCOLOR(224, 40, 40);
            _titleLb.textColor = LH_RGBCOLOR(242, 154, 21);
            _useBtn.backgroundColor = __DefaultColor;
             [_useBtn setTitle:@"立即使用" forState:BtnNormal];
        }
            break;
        case 1:
        {
            _notiLb.textColor = LH_RGBCOLOR(224, 40, 40);
            _titleLb.textColor = LH_RGBCOLOR(255, 85, 0);
            _useBtn.backgroundColor = LH_RGBCOLOR(187, 83, 18);
             [_useBtn setTitle:@"立即使用" forState:BtnNormal];
        }
            break;
        case 2:
        {
            _notiLb.textColor = LH_RGBCOLOR(224, 40, 40);
            _titleLb.textColor =  LH_RGBCOLOR(23, 141, 122);
            _useBtn.backgroundColor = LH_RGBCOLOR(23, 141, 122);
            [_useBtn setTitle:@"立即使用" forState:BtnNormal];
        }
            break;
        case 3:
        {
            _titleLb.textColor = LH_RGBCOLOR(102, 102, 102);
            _useBtn.backgroundColor = LH_RGBCOLOR(170, 169, 169);
            [_useBtn setTitle:@"已使用" forState:BtnNormal];
            _useBtn.userInteractionEnabled = NO;
            _notiLb.textColor = LH_RGBCOLOR(207, 207, 207);
        }
            break;
        case 4:{
            _titleLb.textColor = LH_RGBCOLOR(102, 102, 102);
            _useBtn.backgroundColor = LH_RGBCOLOR(170, 169, 169);
            [_useBtn setTitle:@"已过期" forState:BtnNormal];
            _useBtn.userInteractionEnabled = NO;
            _notiLb.textColor = LH_RGBCOLOR(207, 207, 207);
        }
            break;
        case 5:{
            _titleLb.textColor = LH_RGBCOLOR(102, 102, 102);
            _useBtn.backgroundColor = LH_RGBCOLOR(170, 169, 169);
            [_useBtn setTitle:@"不可使用" forState:BtnNormal];
            _useBtn.userInteractionEnabled = NO;
            _notiLb.textColor = LH_RGBCOLOR(207, 207, 207);
        }
            break;
        default:
            break;
    }
}


- (void)setModel:(YScouponModel *)model {
    _model = model;
    _titleLb.text = [NSString stringWithFormat:@"订单满%ld元使用",[model.condition integerValue]];

    NSMutableAttributedString *attr = [[NSMutableAttributedString alloc]initWithString:[NSString stringWithFormat:@"¥%@",model.value]];
    [attr addAttribute:NSFontAttributeName value:MFont(12) range:NSMakeRange(0, 1)];
    [attr addAttribute:NSFontAttributeName value:BFont(25) range:NSMakeRange(1, attr.length-4)];
    [attr addAttribute:NSFontAttributeName value:MFont(13) range:NSMakeRange(attr.length-3, 3)];
    _moneyLb.attributedText = attr;

    NSDateFormatter *formatter = [[NSDateFormatter alloc]init];
    [formatter setDateStyle:@"yyyy.MM.dd"];
    NSDate *start = [NSDate dateWithTimeIntervalSince1970:[model.startTime integerValue]];
    NSDate *end = [NSDate dateWithTimeIntervalSince1970:[model.endTime integerValue]];
    NSDate *now = [NSDate date];

   NSComparisonResult result = [now compare:end];
    if (result == NSOrderedDescending ) {
        _isOut = YES;
    }else{
        _isOut = NO;
    }

    _timeLb.text = [NSString stringWithFormat:@"%@--%@",[formatter stringFromDate:start],[formatter stringFromDate:end]];
}


@end
