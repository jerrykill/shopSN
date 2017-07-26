//
//  YSPersonalHeadCell.m
//  shopsN
//
//  Created by imac on 2016/12/17.
//  Copyright © 2016年 联系QQ:1084356436. All rights reserved.
//

#import "YSPersonalHeadCell.h"

@interface YSPersonalHeadCell()

@property (strong,nonatomic) UIImageView *backIV;
/**VIP合约用户*/
@property (strong,nonatomic) UIButton *vipBtn;
/**标题*/
@property (strong,nonatomic) UILabel *titleLb;
/**团购兑换*/
@property (strong,nonatomic) UIButton *exchangeBtn;
/**消息按钮*/
@property (strong,nonatomic) UIButton *newsBtn;
/**邀请有礼*/
@property (strong,nonatomic) UIButton *welcomeBtn;
/**设置*/
@property (strong,nonatomic) UIButton *settingBtn;
/**用户头像*/
@property (strong,nonatomic) UIImageView *headIV;
/**账户管理*/
@property (strong,nonatomic) UIButton *userManagerBtn;
/**用户名*/
@property (strong,nonatomic) UILabel *nameLb;

@end

@implementation YSPersonalHeadCell

-(instancetype)initWithFrame:(CGRect)frame{
    if (self = [super initWithFrame:frame]) {
        self.backgroundColor =  [UIColor clearColor];
        [self initView];
    }
    return self;
}

-(void)initView{
    [self addSubview:self.backIV];
//    [self addSubview:self.vipBtn];
    [self addSubview:self.titleLb];
//    [self addSubview:self.exchangeBtn];
    [self addSubview:self.newsBtn];
//    [self addSubview:self.welcomeBtn];
    [self addSubview:self.settingBtn];
    [self addSubview:self.headIV];
    [self addSubview:self.userManagerBtn];
    [self addSubview:self.nameLb];
}

#pragma mark ==懒加载==
- (UIImageView *)backIV{
    if (!_backIV) {
        _backIV = [[UIImageView alloc]initWithFrame:CGRectMake(0, 0, __kWidth, 187.5)];
        _backIV.contentMode = UIViewContentModeScaleAspectFill;
        _backIV.image = MImage(@"bg");
    }
    return _backIV;
}

//- (UIButton *)vipBtn{
//    if (!_vipBtn) {
//        _vipBtn = [[UIButton alloc]initWithFrame:CGRectMake(10, 31, 80, 25)];
//        _vipBtn.titleLabel.font = MFont(14);
//        [_vipBtn setTitle:@"VIP合约客户" forState:BtnNormal];
//        [_vipBtn setTitleColor:[UIColor whiteColor] forState:BtnNormal];
//        [_vipBtn addTarget:self action:@selector(applyVip) forControlEvents:BtnTouchUpInside];
//    }
//    return _vipBtn;
//}

-(UILabel *)titleLb{
    if (!_titleLb) {
        _titleLb = [[UILabel alloc]initWithFrame:CGRectMake((__kWidth-120)/2, 34, 120, 20)];
        _titleLb.textAlignment = NSTextAlignmentCenter;
        _titleLb.font = BFont(18);
        _titleLb.textColor = [UIColor whiteColor];
        _titleLb.text = @"个人中心";
    }
    return _titleLb;
}

//-(UIButton *)exchangeBtn{
//    if (!_exchangeBtn) {
//        _exchangeBtn = [[UIButton alloc]initWithFrame:CGRectMake(__kWidth-100, 31, 60, 25)];
//        _exchangeBtn.titleLabel.font = MFont(14);
//        [_exchangeBtn setTitle:@"团购兑换" forState:BtnNormal];
//        [_exchangeBtn setTitleColor:[UIColor whiteColor] forState:BtnNormal];
//        [_exchangeBtn addTarget:self action:@selector(exchange) forControlEvents:BtnTouchUpInside];
//    }
//    return _exchangeBtn;
//}

-(UIButton *)newsBtn{
    if (!_newsBtn) {
        _newsBtn  = [[UIButton alloc]initWithFrame:CGRectMake(__kWidth-35, 31, 25, 25)];
        _newsBtn.titleLabel.font = MFont(15);
        [_newsBtn setImage:MImage(@"head_news") forState:BtnNormal];
        [_newsBtn addTarget:self action:@selector(chooseNews) forControlEvents:BtnTouchUpInside];
    }
    return _newsBtn;
}
//
//-(UIButton *)welcomeBtn{
//    if (!_welcomeBtn) {
//        _welcomeBtn = [[UIButton alloc]initWithFrame:CGRectMake(10, 85, 50, 60)];
//        _welcomeBtn.titleLabel.font = MFont(13);
//        [_welcomeBtn setTitle:@"邀请有礼" forState:BtnNormal];
//        [_welcomeBtn setImage:MImage(@"my_invite") forState:BtnNormal];
//        [_welcomeBtn setTitleColor:[UIColor whiteColor] forState:BtnNormal];
//        _welcomeBtn.titleEdgeInsets = UIEdgeInsetsMake(15, -23, 0, 0);
//        _welcomeBtn.imageEdgeInsets = UIEdgeInsetsMake(-15, 5, 15, 0);
//        [_welcomeBtn addTarget:self action:@selector(chooseInvite) forControlEvents:BtnTouchUpInside];
//    }
//    return _welcomeBtn;
//}


-(UIButton *)settingBtn{
    if (!_settingBtn) {
        _settingBtn = [[UIButton alloc]initWithFrame:CGRectMake((__kWidth/2-45-30)/2, 92.5, 30, 30)];
        _settingBtn.layer.cornerRadius = 15;
        [_settingBtn setImage:MImage(@"my_setting") forState:BtnNormal];
        [_settingBtn addTarget:self action:@selector(chooseSet) forControlEvents:BtnTouchUpInside];
    }
    return _settingBtn;
}

-(UIImageView *)headIV{
    if (!_headIV) {
        _headIV = [[UIImageView alloc]initWithFrame:CGRectMake((__kWidth-90)/2, 65, 90, 90)];
        _headIV.layer.cornerRadius = 45;
        _headIV.layer.borderColor = LH_RGBCOLOR(244, 150, 130).CGColor;
        _headIV.layer.borderWidth = 2.5;
        _headIV.image =MImage(@"user_head");
        _headIV.clipsToBounds = YES;
        _headIV.contentMode =UIViewContentModeScaleAspectFill;
    }
    return _headIV;
}

-(UIButton *)userManagerBtn{
    if (!_userManagerBtn) {
        _userManagerBtn = [[UIButton alloc]initWithFrame: CGRectMake(__kWidth-85, 92.5, 100, 30)];
        _userManagerBtn.layer.cornerRadius = 15;
        _userManagerBtn.backgroundColor = [UIColor whiteColor];
        [_userManagerBtn setTitle:@"账户管理" forState:BtnNormal];
        [_userManagerBtn setTitleColor:LH_RGBCOLOR(115, 115, 115) forState:BtnNormal];
        [_userManagerBtn setImage:MImage(@"Account") forState:BtnNormal];
        _userManagerBtn.titleLabel.font = MFont(14);
        [_userManagerBtn addTarget:self action:@selector(chooseManager) forControlEvents:BtnTouchUpInside];
        _userManagerBtn.titleEdgeInsets = UIEdgeInsetsMake(0, -6, 0, 0);
        _userManagerBtn.imageEdgeInsets = UIEdgeInsetsMake(0, 0, 0, 60);
    }
    return _userManagerBtn;
}

-(UILabel *)nameLb{
    if (!_nameLb) {
        _nameLb = [[UILabel alloc]initWithFrame:CGRectMake(0, CGRectYH(_headIV)+5, __kWidth, 15)];
        _nameLb.textAlignment = NSTextAlignmentCenter;
        _nameLb.textColor = [UIColor whiteColor];
        _nameLb.font = MFont(13);
    }
    return _nameLb;
}


-(void)setUserName:(NSString *)userName{
    _nameLb.text = userName;
}

-(void)setImageName:(NSString *)imageName{
    [_headIV sd_setImageWithURL:[NSURL URLWithString:[NSString stringWithFormat:@"%@%@",HomeADUrl,imageName]] placeholderImage:MImage(@"user_head")];
}

//#pragma mark ==申请VIP==
//- (void)applyVip{
//    [self.delegate vipCustomApply];
//}

#pragma mark ==查看消息==
-(void)chooseNews{
    [self.delegate seeNews];
}

//#pragma mark ==兑换==
//- (void)exchange{
//    [self.delegate groupExchange];
//}

//#pragma mark ==邀请==
//-(void)chooseInvite{
//    [self.delegate chooseInviteGood];
//}

#pragma mark ==设置==
-(void)chooseSet{
    [self.delegate goSetting];
}

#pragma mark ==账户管理==
- (void)chooseManager{
    [self.delegate userManage];
}



@end
