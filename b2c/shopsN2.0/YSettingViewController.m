//
//  YSettingViewController.m
//  shopsN
//
//  Created by imac on 2016/12/19.
//  Copyright © 2016年 联系QQ:1084356436. All rights reserved.
//

#import "YSettingViewController.h"
#import "YSettingCell.h"
#import "YSettingFooterView.h"

@interface YSettingViewController ()<UITableViewDelegate,UITableViewDataSource,YSettingCellDelegate>

@property (strong,nonatomic) UITableView *tableV;

@property (assign,nonatomic) BOOL isNoti;

@property (assign,nonatomic) BOOL isAlert;

@property (assign,nonatomic) BOOL isRing;

@property (assign,nonatomic) BOOL isShake;

@property (strong,nonatomic) NSDictionary *notiDic;

@end

@implementation YSettingViewController


- (void)viewDidLoad {
    [super viewDidLoad];
    self.title = @"设置";
    _isNoti = YES;


    if ([[[UIDevice currentDevice] systemVersion] doubleValue] >=8.0 ? YES : NO) { //iOS8以上包含iOS8
        if ([[UIApplication sharedApplication] currentUserNotificationSettings].types==UIRemoteNotificationTypeNone) {
            _isNoti = NO;
        }
    }else{ // ios7 一下
        if ([[UIApplication sharedApplication] enabledRemoteNotificationTypes]==UIRemoteNotificationTypeNone) {
             _isNoti = NO;
        }
    }
    if (!_isNoti) {
        _isAlert = NO;
        _isShake = NO;
        _isRing = NO;
    }else{
        _isAlert = YES;
        _isShake = YES;
        _isRing = YES;
    }

    [self initView];
}

-(void)initView{
    _tableV = [[UITableView alloc]initWithFrame:CGRectMake(0, 75, __kWidth, __kHeight-75)];
    [self.view addSubview:_tableV];
    _tableV.backgroundColor = [UIColor clearColor];;
    _tableV.delegate=self;
    _tableV.dataSource = self;
    _tableV.separatorColor = [UIColor clearColor];
}


#pragma mark ==UITableViewDelegate==
-(NSInteger)numberOfSectionsInTableView:(UITableView *)tableView{
    return 3;
}

-(NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section{
    if (section==2) {
        return 2;
    }else{
        return 1;
    }
}

-(UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath{
    YSettingCell *cell =[tableView dequeueReusableCellWithIdentifier:@"YSettingCell"];
    if (!cell) {
        cell = [[YSettingCell alloc]initWithStyle:UITableViewCellStyleDefault reuseIdentifier:@"YSettingCell"];
    }
    if (indexPath.section==0) {
        cell.detailLb.hidden = NO;
        cell.switChoose.hidden = YES;
        cell.title = @"接收新消息通知";
        if (_isNoti) {
            cell.detailLb.text = @"已开启";
        }else{
            cell.detailLb.text = @"已停用";
        }
    }else if (indexPath.section==1){
        cell.title = [NSString stringWithFormat:@"新消息%@APP内横幅提醒",ShortTitle];
        cell.switChoose.on = _isAlert;
        cell.tag = 1;
    }else{
        if (indexPath.row==0) {
            cell.title = @"铃声提醒";
            cell.switChoose.on = _isRing;
            cell.tag = 2;
        }else{
            cell.title = @"震动提醒";
            cell.switChoose.on = _isShake;
            cell.tag = 3;
        }
    }
     cell.delegate = self;
    return cell;
}

-(UIView *)tableView:(UITableView *)tableView viewForHeaderInSection:(NSInteger)section{
    if (section==2) {
        UIView *headV = [[UIView alloc]initWithFrame:CGRectMake(0, 0, __kWidth, 30)];
        headV.backgroundColor = [UIColor clearColor];

        UILabel *titleLb = [[UILabel alloc]initWithFrame:CGRectMake(12, 5, __kWidth-40, 15)];
        [headV addSubview:titleLb];
        titleLb.textAlignment = NSTextAlignmentLeft;
        titleLb.font = MFont(13);
        titleLb.textColor = __TextColor;
        titleLb.text = @"提示音效";
        return headV;
    }else{
        return nil;
    }
}

-(UIView *)tableView:(UITableView *)tableView viewForFooterInSection:(NSInteger)section{
    if (section==0) {
        YSettingFooterView *footer = [[YSettingFooterView alloc]initWithFrame:CGRectMake(0, 0, __kWidth, 64)];
        footer.title = [NSString stringWithFormat:@"要开启或停用，你可以在设置>通知中心>%@中手动设置",simpleTitle];
        return footer;
    }else if (section==1){
        YSettingFooterView *footer = [[YSettingFooterView alloc]initWithFrame:CGRectMake(0, 0, __kWidth, 89)];
        footer.title =  [NSString stringWithFormat:@"关闭后，您在使用%@时收到的消息，将不再以横幅样式提醒",simpleTitle];
        return footer;
    }else{
        return nil;
    }
}

-(CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath{
    return 47;
}
-(CGFloat)tableView:(UITableView *)tableView heightForFooterInSection:(NSInteger)section{
    if (section==0) {
        return 64;
    }else if (section==1){
        return 89;
    }else{
        return 0;
    }
}

-(CGFloat)tableView:(UITableView *)tableView heightForHeaderInSection:(NSInteger)section{
    if (section==2) {
        return 30;
    }else{
        return 0;
    }
}

#pragma mark ==YSettingCellDelegate==
-(void)chooseSwitch:(BOOL)sender index:(NSInteger)tag{
    NSMutableDictionary *data =[[NSMutableDictionary alloc]init];
    [data setObject:[NSNumber numberWithBool:_isAlert] forKey:@"alert"];
    [data setObject:[NSNumber numberWithBool:_isRing] forKey:@"sound"];
    [data setObject:[NSNumber numberWithBool:_isShake] forKey:@"shake"];

    if (_isNoti) {
      switch (tag) {
           case 1:
           {
               _isAlert = sender;
               NSLog(@"%@",sender?@"提示":@"不提示");
               [data setObject:[NSNumber numberWithBool:_isAlert] forKey:@"alert"];
               if(!_isAlert){
                   [SXLoadingView showAlertHUD:@"该设置仅在APP使用时有效，其他模式需要到设置中修改" duration:SXLoadingTime];
               }

           }
             break;
           case 2:
           {
               _isRing = sender;
               NSLog(@"%@",sender?@"铃声":@"无铃声");
               [data setObject:[NSNumber numberWithBool:_isRing] forKey:@"sound"];
               if(!_isRing){
                   [SXLoadingView showAlertHUD:@"该设置仅在APP使用时有效，其他模式需要到设置中修改" duration:SXLoadingTime];
               }

           }
             break;
           case 3:
           {
               _isShake = sender;
               NSLog(@"%@",sender?@"震动":@"无震动");
               [data setObject:[NSNumber numberWithBool:_isShake] forKey:@"shake"];
               if(!_isShake){
                   [SXLoadingView showAlertHUD:@"该设置仅在APP使用时有效，其他模式需要到设置中修改" duration:SXLoadingTime];
               }
           }
             break;
           default:
             break;
       }
        [[NSNotificationCenter defaultCenter]postNotificationName:YSNotificationChange object:data userInfo:nil];

    }else{
        [SXLoadingView showAlertHUD:[NSString stringWithFormat:@"在设置>通知中心>%@中手动打开通知，才可以设置",simpleTitle] duration:1.5];
    }


}



- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

/*
#pragma mark - Navigation

// In a storyboard-based application, you will often want to do a little preparation before navigation
- (void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender {
    // Get the new view controller using [segue destinationViewController].
    // Pass the selected object to the new view controller.
}
*/

@end
