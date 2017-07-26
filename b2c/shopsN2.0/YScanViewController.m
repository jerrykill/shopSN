//
//  YScanViewController.m
//  shopsN
//
//  Created by imac on 2017/2/7.
//  Copyright © 2017年 联系QQ:1084356436. All rights reserved.
//

#import "YScanViewController.h"
#import <AVFoundation/AVFoundation.h>
#import "ZBarSDK.h"
#import "QRView.h"

@interface YScanViewController ()<AVCaptureMetadataOutputObjectsDelegate,ZBarReaderDelegate,UIAlertViewDelegate>

@property ( strong , nonatomic ) AVCaptureDevice * device;
@property ( strong , nonatomic ) AVCaptureDeviceInput * input;
@property ( strong , nonatomic ) AVCaptureMetadataOutput * output;
@property ( strong , nonatomic ) AVCaptureSession * session;
@property ( strong , nonatomic ) AVCaptureVideoPreviewLayer * previewLayer;

@property (strong,nonatomic) NSString *urlString;

@end

@implementation YScanViewController



- (void)viewDidLoad {
    [super viewDidLoad];
    self.title = @"扫一扫";
    [self startScan];
    [self.view bringSubviewToFront:self.headV];
}
#pragma mark ==开始扫描==
-(void)startScan{
    // 检查授权
    NSString *mediaType = AVMediaTypeVideo;
    AVAuthorizationStatus authStatus = [AVCaptureDevice authorizationStatusForMediaType:mediaType];
    if (authStatus == AVAuthorizationStatusDenied || authStatus == AVAuthorizationStatusRestricted) {
        [self dismissViewControllerAnimated:YES completion:nil];
        return;
    }

    self.device = [AVCaptureDevice defaultDeviceWithMediaType:mediaType];

    self.input = [AVCaptureDeviceInput deviceInputWithDevice:self.device error:nil];

    self.output = [[AVCaptureMetadataOutput alloc] init];
    [self.output setMetadataObjectsDelegate:self queue:dispatch_get_main_queue()];

    self.session = [[AVCaptureSession alloc] init];

    [self.session setSessionPreset:AVCaptureSessionPresetHigh];

    if ([self.session canAddInput:self.input]) {
        [self.session addInput:self.input];
    }
    if ([self.session canAddOutput:self.output]) {
        [self.session addOutput:self.output];
    }
    // 条码类型
    self.output.metadataObjectTypes = @[AVMetadataObjectTypeQRCode];

    self.previewLayer = [AVCaptureVideoPreviewLayer layerWithSession:self.session];
    self.previewLayer.videoGravity = AVLayerVideoGravityResize;
    self.previewLayer.frame = CGRectMake(0, 0, __kWidth, __kHeight);
    [self.view.layer insertSublayer:self.previewLayer atIndex:0];
    [self.session startRunning];

     QRView *qrView = [[QRView alloc] initWithFrame:CGRectMake(0, 0, __kWidth, __kHeight)];
    CGSize size = CGSizeZero;
    if (self.view.frame.size.width > 320) {
        size = CGSizeMake(300, 300);
    } else {
        size = CGSizeMake(200, 200);
    }

    qrView.transparentArea = size;
    qrView.backgroundColor = [UIColor clearColor];
    qrView.center = CGPointMake(self.view.frame.size.width / 2, self.view.frame.size.height / 2);
    [self.view addSubview:qrView];

    UILabel *tipLabel = [[UILabel alloc] initWithFrame:CGRectMake(0, qrView.center.y - size.height/2 - 30,
                                                                  self.view.frame.size.width, 20)];
    tipLabel.text = @"请将摄像头对准二维码 即可自动扫描";
    tipLabel.textColor = [UIColor whiteColor];
    tipLabel.font = [UIFont systemFontOfSize:15];
    tipLabel.textAlignment = NSTextAlignmentCenter;

    UIButton *myQRViewBtn = [[UIButton alloc] initWithFrame:CGRectMake(qrView.frame.origin.x,
                                                                       qrView.center.y + size.height/2 + 15,
                                                                       qrView.frame.size.width, 20)];
    [myQRViewBtn setTitleColor:[UIColor greenColor] forState:UIControlStateNormal];
    myQRViewBtn.titleLabel.font = [UIFont systemFontOfSize:15];
    [myQRViewBtn setTitle:@"我的二维码" forState:UIControlStateNormal];


    [self.view addSubview:tipLabel];
    [self.view addSubview:myQRViewBtn];

}

#pragma mark -----AVCaptureFileOutputRecordingDelegate
- (void)captureOutput:(AVCaptureOutput *)captureOutput didOutputMetadataObjects:(NSArray *)metadataObjects
       fromConnection:(AVCaptureConnection *)connection {
    if (metadataObjects.count > 0) {
        [self.session stopRunning];
        AVMetadataMachineReadableCodeObject *metaDataObject = [metadataObjects firstObject];

        self.urlString = metaDataObject.stringValue;
        NSLog(@"-----%@",self.urlString);
    }

    [self handelURLString:self.urlString];
}


//https://www.baidu.com
// 处理扫描的字符串
-(void)handelURLString:(NSString *)string
{

    NSArray * array = [string componentsSeparatedByString:@"/"];
    if ([string hasPrefix:@"http"]) {

        NSLog(@"%@", array);
        if (array.firstObject) {
            // 这里用户根据自己的业务逻辑进行处理 比如判断字符串是否包含某个特定的字符串 然后根据url跳转到响应的界面(如个人详情加好友页面....)
            if ([array[2] isEqualToString:@"www.baidu.com"]) {
                [self.session startRunning];
                [[UIApplication sharedApplication] openURL:[NSURL URLWithString:@"https://www.baidu.com"]];
            }else{
                UIAlertView *alertView=[[UIAlertView alloc] initWithTitle:@"提示"message:[NSString stringWithFormat:@"该链接可能存在风险\n%@",string] delegate:self cancelButtonTitle:@"取消"otherButtonTitles:@"打开链接",nil];
                alertView.tag = 100086;
                alertView.delegate = self;
                self.urlString = string;
                [self.session stopRunning];
                [alertView show];
            }
        }
    }else{
        UIAlertView *alertView=[[UIAlertView alloc] initWithTitle:@"提示"message:[NSString stringWithFormat:@"扫描结果:\n%@",string] delegate:self cancelButtonTitle:@"确定"otherButtonTitles:nil];
        alertView.tag = 100087;
        [self.session stopRunning];
        [alertView show];
    }
}
- (void)imagePickerController:(UIImagePickerController *)picker didFinishPickingMediaWithInfo:(NSDictionary<NSString *,id> *)info {
    NSArray *resuluts = [info objectForKey:ZBarReaderControllerResults];

    if (resuluts.count > 0) {
        int quality = 0;
        ZBarSymbol *bestResult = nil;
        for (ZBarSymbol *sym in resuluts) {
            int tempQ = sym.quality;
            if (quality < tempQ) {
                quality = tempQ;
                bestResult = sym;
            }
        }

        [self presentResult:bestResult];
    }
    [picker dismissViewControllerAnimated:YES completion:nil];
}

- (void) presentResult: (ZBarSymbol*)sym {
    if (sym) {
        NSString *tempStr = sym.data;
        if ([sym.data canBeConvertedToEncoding:NSShiftJISStringEncoding]) {
            tempStr = [NSString stringWithCString:[tempStr cStringUsingEncoding:NSShiftJISStringEncoding] encoding:NSUTF8StringEncoding];
        }
        NSLog(@"%@",tempStr);


        [self handelURLString:tempStr];
    }
}


#pragma mark ---alertViewDelegate
- (void)alertView:(UIAlertView *)alertView clickedButtonAtIndex:(NSInteger)buttonIndex {
    if (alertView.tag == 100086) {
        if (buttonIndex == 1) {
            [self.session startRunning];
            [[UIApplication sharedApplication] openURL:[NSURL URLWithString:self.urlString]];
        } else {
            [self.session startRunning];
        }
    }

    if (alertView.tag == 100087) {
        if (buttonIndex == 0) {
            [self.session startRunning];
        }
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
