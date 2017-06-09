//
//  YCompanyLocationViewController.m
//  shopsN
//
//  Created by imac on 2016/12/5.
//  Copyright © 2016年 联系QQ:1084356436. All rights reserved.
//

#import "YCompanyLocationViewController.h"


@interface YCompanyLocationViewController ()<BMKMapViewDelegate,BMKLocationServiceDelegate>

@property (strong,nonatomic) BMKMapView *mapView;

@property(nonatomic,strong)NSString* currentLatitude;//当前纬度
@property(nonatomic,strong)NSString* currentLongtitude;//当前经度

@end

@implementation YCompanyLocationViewController


-(void)viewWillAppear:(BOOL)animated{
    [super viewWillAppear:YES];
    [_mapView viewWillAppear];
    _mapView.delegate = self; // 此处记得不用的时候需要置nil，否则影响内存的释放
}
-(void)viewWillDisappear:(BOOL)animated{
    [super viewWillDisappear:YES];
    [_mapView viewWillDisappear];
    _mapView.delegate = nil; // 不用时，置nil
}

- (void)viewDidLoad {
    [super viewDidLoad];
    self.title = @"企业位置";
    _currentLatitude = @"31.000513515";
    _currentLongtitude = @"121.046151515";
    [self initView];
}

- (void)initView{
    _mapView = [[BMKMapView alloc]initWithFrame:CGRectMake(0, 64, __kWidth, __kHeight-64)];
    [self.view addSubview:_mapView];
    _mapView.delegate = self;

    BMKPointAnnotation *location =[[BMKPointAnnotation alloc]init];
    location.coordinate = CLLocationCoordinate2DMake([_currentLatitude doubleValue], [_currentLongtitude doubleValue]);

    [_mapView setCenterCoordinate:location.coordinate animated:YES];
    [_mapView addAnnotation:location];

    
}
#pragma - mark BMKMapViewDelegate
//根据anntation生成对应的view
-(BMKAnnotationView *)mapView:(BMKMapView *)mapView viewForAnnotation:(id<BMKAnnotation>)annotation
{
    BMKPinAnnotationView *annotationView = [[BMKPinAnnotationView alloc] initWithAnnotation:annotation reuseIdentifier:@"annotationViewID"];
    // 设置颜色
    annotationView.pinColor = BMKPinAnnotationColorRed;
    // 从天上掉下效果
    annotationView.animatesDrop =NO;

    UIView *popV = [[UIView alloc]initWithFrame:CGRectMake(0, 0, 200, 55)];
    popV.backgroundColor = [UIColor clearColor];

    UIView *backV = [[UIView alloc]initWithFrame:CGRectMake(0, 0, 200, 45)];
    backV.layer.cornerRadius = 5;
    [popV addSubview:backV];
    backV.backgroundColor = [UIColor whiteColor];

    UIImageView *jinIV = [[UIImageView alloc]initWithFrame:CGRectMake((200-40)/2+5, 45, 40, 10)];
    [popV addSubview:jinIV];
    jinIV.image = MImage(@"箭头");
    jinIV.contentMode = UIViewContentModeScaleAspectFit;

    UILabel *titleLb = [[UILabel alloc]initWithFrame:CGRectMake(10, 0, 180, 20)];
    [popV addSubview:titleLb];
    titleLb.textAlignment = NSTextAlignmentLeft;
    titleLb.textColor = __DTextColor;
    titleLb.font = MFont(16);
    titleLb.text = @"所在位置：";

    UILabel *addressLb = [[UILabel alloc]initWithFrame:CGRectMake(10, CGRectYH(titleLb)+2, 180, 15)];
    [popV addSubview:addressLb];
    addressLb.textAlignment = NSTextAlignmentLeft;
    addressLb.textColor = __TextColor;
    addressLb.font = MFont(13);
    addressLb.text = @"上海市闵行区江月路";

    BMKActionPaopaoView *pView = [[BMKActionPaopaoView alloc]initWithCustomView:popV];
    pView.frame = CGRectMake(0, 0, 210, 53);
    annotationView.paopaoView = nil;
    annotationView.paopaoView = pView;
    annotationView.centerOffset = CGPointMake(0, -(annotationView.frame.size.height * 0.5));
    annotationView.annotation = annotation;
    annotationView.canShowCallout = TRUE;
    return annotationView;
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
