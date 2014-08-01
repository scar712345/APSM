//
//  APSMViewController.m
//  APSM
//
//  Created by APP559 on 2014/7/16.
//  Copyright (c) 2014年 yume. All rights reserved.
//

#import "APSMViewController.h"
#import "VerticalUILabel.h"
#import "Language.h"
#import "yumeBTLERemoteController.h"
#import "Pages.h"

@interface APSMViewController ()<UIAlertViewDelegate>
{
    UIAlertView *alertSettingPush;
    UIAlertView *alertParameterPush;
    UIAlertView *alertConnectedPush;
    UIAlertView *alertLanguage;
}

@property (weak, nonatomic) IBOutlet UIButton *btnScanDevice;
@property (weak, nonatomic) IBOutlet UIButton *btnDisconnectDevice;
@property (weak, nonatomic) IBOutlet UILabel *labelConnectingStatus;
@property (weak, nonatomic) IBOutlet UIView *viewWarning;
@property (weak, nonatomic) IBOutlet UIImageView *imgLight;
@property (weak, nonatomic) IBOutlet UILabel *labelCaution;
//@property (weak, nonatomic) IBOutlet UILabel *labelWarning;
@property (weak, nonatomic) IBOutlet VerticalUILabel *labelWarning;

@property (weak, nonatomic) IBOutlet UIScrollView *scrollViewWarning;

@end

@implementation APSMViewController

#pragma mark - View Controller's Method

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
    [self lockButtonWhenDisconnect];
//    [yumeBTLERemoteController sharedInstance].rootVC = self;
    
//    [[NSNotificationCenter defaultCenter]addObserver:self selector:@selector(sendData:) name:@"sendData" object:self];
    [NotificationCenter addObserver:self selector:@selector(connect:) name:@"connect" object:YumeBTSharedInstance];
    [NotificationCenter addObserver:self selector:@selector(disconnect:) name:@"disconnect" object:YumeBTSharedInstance];
    
    [self prepareNavigationIcon];
    
    [self.btnScanDevice setTitle:NSLocalizedString(@"Search Device - Bluetooth",nil) forState:UIControlStateNormal];
    [self.btnDisconnectDevice setTitle:NSLocalizedString(@"Disconnect",nil) forState:UIControlStateNormal];
//    [self.btnSettingPage setTitle:NSLocalizedString(@"Setup Menu",nil) forState:UIControlStateNormal];
//    [self.btnParameterPage setTitle:NSLocalizedString(@"Parameter Menu",nil) forState:UIControlStateNormal];
    self.labelCaution.text = [Language get:@"Caution" alter:nil];
    self.labelWarning.text = NSLocalizedString(@"WarningMessageFirstPage",nil);
    
    self.viewWarning.backgroundColor = [UIColor colorWithRed:0 green:0 blue:0 alpha:0.5];
    self.scrollViewWarning.indicatorStyle = UIScrollViewIndicatorStyleWhite;
}

-(void)viewDidLayoutSubviews
{
    _labelWarning.verticalAlignment = VerticalAlignmentTop;
    CGSize maximumLabelSize = CGSizeMake(260, FLT_MAX);
    NSDictionary *stringAttributes = [NSDictionary dictionaryWithObject:[UIFont systemFontOfSize:18] forKey: NSFontAttributeName];
    CGRect frame = [_labelWarning.text boundingRectWithSize:maximumLabelSize
                                                    options:NSStringDrawingTruncatesLastVisibleLine|NSStringDrawingUsesLineFragmentOrigin
                                                 attributes:stringAttributes context:nil];
    _labelWarning.frame = CGRectMake(0, 0, 260, frame.size.height);
    _scrollViewWarning.contentSize = CGSizeMake(240, frame.size.height);
    
    self.scrollView.contentSize = CGSizeMake(ScreenWidth, self.lastView.frame.origin.y + self.lastView.frame.size.height);
    self.scrollView.frame = CGRectMake(0, 64, ScreenWidth, ScreenHeight - 64);
}

#pragma mark - Notification

-(void)connect:(NSNotification*) notification {
    [self lockButtonWhenConnected];
}

-(void)disconnect:(NSNotification*) notification {
    [self lockButtonWhenDisconnect];
    [self.navigationController popToRootViewControllerAnimated:YES];
}

#pragma mark - Prepare Navigation Icon

-(void)prepareNavigationIcon{
    UIImage *buttonImage = [UIImage imageNamed:@"phone_h_icon(44x44).png"];
    UIButton *aButton = [UIButton buttonWithType:UIButtonTypeCustom];
    [aButton setImage:buttonImage forState:UIControlStateNormal];
    aButton.frame = CGRectMake(0.0,0.0,buttonImage.size.width,buttonImage.size.height);
    //    [aButton addTarget:self action:@selector(aSelector) forControlEvents:UIControlEventTouchUpInside];
    UIBarButtonItem *backButton = [[UIBarButtonItem alloc] initWithCustomView:aButton];
    self.navigationItem.leftBarButtonItem = backButton;
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

#pragma mark - Button

- (IBAction)btnDevice:(id)sender {
    [YumeBTSharedInstance startScanWithShowDeviceList];
}

- (IBAction)btnDisconnect:(id)sender {
    [YumeBTSharedInstance disconnet];
}

- (IBAction)loadAPSMData:(id)sender {
//    [[yumeBTLERemoteController sharedInstance].fileController loadParameterData];
}

- (IBAction)saveAPSMData:(id)sender {
}

#pragma mark - Lock/Unlock Buttons

-(void)lockButtonWhenDisconnect{
    self.btnScanDevice.hidden = NO;
    self.btnDisconnectDevice.hidden = YES;
    self.labelConnectingStatus.textColor = [UIColor redColor];
    self.labelConnectingStatus.text = [Language get:@"Disconnected" alter:nil];
    self.imgLight.image = [UIImage imageNamed:@"link_r"];
    
    self.labelDevice.text = @" ";
}

-(void)lockButtonWhenConnected{
    self.btnScanDevice.hidden = YES;
    self.btnDisconnectDevice.hidden = NO;
    self.labelConnectingStatus.textColor = [UIColor greenColor];
    self.labelConnectingStatus.text = [Language get:@"Connected" alter:nil];
    self.imgLight.image = [UIImage imageNamed:@"link_g"];
}

-(void)alertView:(UIAlertView *)alertView clickedButtonAtIndex:(NSInteger)buttonIndex{
    if (alertView == alertLanguage) {
        if (buttonIndex == 0) {
            return;
        }
        
        NSArray *languages = @[@"zh-Hant",@"zh-Hans",@"en",@"de",@"fr"];
        if ((buttonIndex - 1) > languages.count) {
            return;
        }
        [Language setLanguage:(NSString *)languages[buttonIndex - 1]];
        
        self.labelCaution.text=[Language get:@"Caution" alter:nil];
        [self.btnScanDevice setTitle:[Language get:@"Search Device - Bluetooth" alter:nil] forState:UIControlStateNormal];
        [self.btnDisconnectDevice setTitle:[Language get:@"Disconnect" alter:nil] forState:UIControlStateNormal];
//        [self.btnSettingPage setTitle:[Language get:@"Setup Menu" alter:nil] forState:UIControlStateNormal];
//        [self.btnParameterPage setTitle:[Language get:@"Parameter Menu" alter:nil] forState:UIControlStateNormal];
        self.labelWarning.text=NSLocalizedString(@"WarningMessageFirstPage",nil);
        
        if (self.btnScanDevice.hidden==NO) {
            self.labelConnectingStatus.text=[Language get:@"Disconnected" alter:nil];
        }else{
            self.labelConnectingStatus.text=[Language get:@"Connected" alter:nil];
        }
        //        [self viewDidLayoutSubviews];
    }
}

#pragma mark - Navigation Push View Controller

- (IBAction)pushToAPSMSettingPage:(id)sender {
    Pages *APSMPages = [self.storyboard instantiateViewControllerWithIdentifier:@"Pages"];
    NSArray *arrayTitle = @[NSLocalizedString(@"遙控器與接收器", nil),
                            NSLocalizedString(@"感度與飛行器類型", nil),
                            NSLocalizedString(@"GPS感應器位置與保護裝置", nil),
                            NSLocalizedString(@"定點巡航拍攝功能", nil),
                            NSLocalizedString( @"OSD設定", nil)];
    
    APSMPages.alert = [[UIAlertView alloc] initWithTitle:NSLocalizedString(@"APSM Setting",nil)
                                                 message:nil
                                                delegate:nil
                                       cancelButtonTitle:NSLocalizedString(@"Cancel",nil)
                                       otherButtonTitles:[arrayTitle objectAtIndex:0],
                                                         [arrayTitle objectAtIndex:1],
                                                         [arrayTitle objectAtIndex:2],
                                                         [arrayTitle objectAtIndex:3],
                                                         [arrayTitle objectAtIndex:4],nil];
    
    APSMPages.pages = @[[self.storyboard instantiateViewControllerWithIdentifier:@"APSM_Page1"],
               [self.storyboard instantiateViewControllerWithIdentifier:@"APSM_Page2"],
               [self.storyboard instantiateViewControllerWithIdentifier:@"APSM_Page3"],
               [self.storyboard instantiateViewControllerWithIdentifier:@"APSM_Page4"],
               [self.storyboard instantiateViewControllerWithIdentifier:@"OSD_Page1"]];
    APSMPages.pageTitle = NSLocalizedString(@"APSM Setting",nil);
    APSMPages.pagesSubTitle = arrayTitle;
    [self.navigationController pushViewController:APSMPages animated:YES];
}

- (IBAction)pushToCradleHeadSettingPage:(id)sender {
    Pages *cradleHeadPages = [self.storyboard instantiateViewControllerWithIdentifier:@"Pages"];
    NSArray *arrayTitle = @[NSLocalizedString(@"雲台基本設定", nil),
                            NSLocalizedString(@"雲台控制設定", nil),
                            NSLocalizedString(@"雲台進階設定", nil)];
    
    cradleHeadPages.alert = [[UIAlertView alloc] initWithTitle:NSLocalizedString(@"CradleHeadPages Setting",nil)
                                                message:nil
                                               delegate:nil
                                      cancelButtonTitle:NSLocalizedString(@"Cancel",nil)
                                      otherButtonTitles:[arrayTitle objectAtIndex:0],
                                                        [arrayTitle objectAtIndex:1],
                                                        [arrayTitle objectAtIndex:2],nil];
    
    cradleHeadPages.pages = @[[self.storyboard instantiateViewControllerWithIdentifier:@"CradleHead_Page1"],
                              [self.storyboard instantiateViewControllerWithIdentifier:@"CradleHead_Page2"],
                              [self.storyboard instantiateViewControllerWithIdentifier:@"CradleHead_Page3"]];
    cradleHeadPages.pageTitle = NSLocalizedString(@"CradleHeadPages Setting",nil);
    cradleHeadPages.pagesSubTitle = arrayTitle;
    [self.navigationController pushViewController:cradleHeadPages animated:YES];
}

#pragma mark - Bottom Three buttons

- (IBAction)btnHowToUse:(id)sender {
    //    HowToUseViewController *vc=[self.storyboard instantiateViewControllerWithIdentifier:@"HowToUseViewController"];
    //    [self.navigationController pushViewController:vc animated:YES];
}

- (IBAction)changeLanguage:(id)sender {
    alertLanguage = [[UIAlertView alloc]initWithTitle:NSLocalizedString(@"Language",nil)
                                              message:nil delegate:self
                                    cancelButtonTitle:NSLocalizedString(@"Cancel",nil)
                                    otherButtonTitles:@"繁體中文",@"简体中文",@"English",@"Deutsch",@"Français", nil];
    [alertLanguage show];
}

- (IBAction)btnWebside:(id)sender {
    [[UIApplication sharedApplication] openURL:[NSURL URLWithString:@"http://www.align.com.tw/Gpro/"]];
}

@end
