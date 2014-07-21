//
//  Pages.m
//  APSM
//
//  Created by APP559 on 2014/7/16.
//  Copyright (c) 2014年 yume. All rights reserved.
//

#import "Pages.h"
#import "TTUIScrollViewSlidingPages.h"
#import "Language.h"
@interface Pages ()<UIAlertViewDelegate,TTScrollSlidingPagesControllerDelegate,TTSlidingPagesDataSource>
@property (weak, nonatomic) IBOutlet UIButton *buttonBack;
@property (weak, nonatomic) IBOutlet UIButton *buttonMenu;
@property (weak, nonatomic) IBOutlet UIButton *buttonNext;
@end

@implementation Pages
@synthesize ttScrollSlidingPagesController;

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
    
    [self prepareTTScrollSlidingPagesController];
    
    [self prepareHomeButton];
    
    [self preparePageTitle];
    
    self.buttonBack.enabled = NO;
    if (_pages.count == 1) {
        self.buttonNext.enabled = NO;
    }

}

-(void)prepareTTScrollSlidingPagesController{
    ttScrollSlidingPagesController = [[TTScrollSlidingPagesController alloc] init];
    ttScrollSlidingPagesController.dataSource = self; /*the current view controller (self) conforms to the TTSlidingPagesDataSource protocol)*/
    ttScrollSlidingPagesController.view.frame =  CGRectMake(0, 59, self.view.frame.size.width, self.view.frame.size.height-100); //I'm setting up the view to be fullscreen in the current view
    ttScrollSlidingPagesController.TTScrollSlidingPagesControllerDelegate=self;
    [self.view addSubview:ttScrollSlidingPagesController.view];
    [self addChildViewController:ttScrollSlidingPagesController];
}

-(void)prepareHomeButton{
    UIImage *buttonImage = [UIImage imageNamed:@"home(32x32).png"];
    UIButton *aButton = [UIButton buttonWithType:UIButtonTypeCustom];
    [aButton setImage:buttonImage forState:UIControlStateNormal];
    aButton.frame = CGRectMake(0.0,0.0,buttonImage.size.width,buttonImage.size.height);
    [aButton addTarget:self action:@selector(aSelector:) forControlEvents:UIControlEventTouchUpInside];
    UIBarButtonItem *backButton = [[UIBarButtonItem alloc] initWithCustomView:aButton];
    self.navigationItem.leftBarButtonItem = backButton;
}

-(void)preparePageTitle{
    
    //    UIImageView *img=[[UIImageView alloc] initWithFrame:CGRectMake(0, 0, self.view.bounds.size.width, 50)];
    //    img.image=[UIImage imageNamed:@"page_buttombackground(1008x64).png"];
    //    [self.view addSubview:img];
    //
    //    UIView *w = [[UIView alloc]initWithFrame:CGRectMake(0, 64, 320, 25)];
    //    w.backgroundColor = [UIColor whiteColor];
    //    [self.view addSubview:w];
    
    UIImageView *imgLabel = [[UIImageView alloc] initWithImage:[UIImage imageNamed:@""]];
    imgLabel.frame = CGRectMake(0, 64, self.view.bounds.size.width, 25);
    [self.view addSubview:imgLabel];
    
    UILabel *labelTitle = [[UILabel alloc] initWithFrame:CGRectMake(0, 2, self.view.bounds.size.width, 21)];
    labelTitle.text = NSLocalizedString(_pageTitle,nil);//[Language get:@"Parameter Menu" alter:nil];
    labelTitle.textAlignment = NSTextAlignmentCenter;
    labelTitle.textColor = [UIColor whiteColor];
    labelTitle.font = [UIFont boldSystemFontOfSize:15];
    labelTitle.layer.shadowColor = [[UIColor blackColor] CGColor];
    labelTitle.layer.shadowOffset = CGSizeMake(0.0f, 0.0f);
    labelTitle.layer.shadowRadius = 2.0f;
    labelTitle.layer.shadowOpacity = 1.0f;
    [imgLabel addSubview:labelTitle];
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

-(int)numberOfPagesForSlidingPagesViewController:(TTScrollSlidingPagesController *)source{
    return (int)[_pages count]; //5 pages. The below two methods will each now get called 5 times, one for
}

-(TTSlidingPage *)pageForSlidingPagesViewController:(TTScrollSlidingPagesController*)source atIndex:(int)index{
    //    Class class = _pages[index];
    //    return [[TTSlidingPage alloc] initWithContentViewController:[class new]];
    return [[TTSlidingPage alloc] initWithContentViewController:_pages[index]];
}


-(TTSlidingPageTitle *)titleForSlidingPagesViewController:(TTScrollSlidingPagesController *)source atIndex:(int)index{
    //    return [[TTSlidingPageTitle alloc]initWithHeaderText:NSLocalizedString(_pagesSubTitle[index], nil)];
    return [[TTSlidingPageTitle alloc]initWithHeaderText:_pagesSubTitle[index]];
}



- (IBAction)buttonBack:(id)sender{
    _buttonNext.enabled=YES;
    _buttonBack.enabled=YES;

    long page = (ttScrollSlidingPagesController.pageControl.currentPage-1) % ttScrollSlidingPagesController.pageControl.numberOfPages;
    CGRect frame = ttScrollSlidingPagesController.bottomScrollView.frame;
    frame.origin.x = frame.size.width * page;
    frame.origin.y = 0;
    [ttScrollSlidingPagesController.bottomScrollView scrollRectToVisible:frame animated:YES];
    ttScrollSlidingPagesController.pageControl.currentPage = page;
    
    if (page == 0) {
        _buttonBack.enabled = NO;
    }
}

- (IBAction)buttonMenu:(id)sender{
    
    //    _alert = [[UIAlertView alloc] initWithTitle:NSLocalizedString(@"Parameter Menu",nil)
    //                                                    message:nil
    //                                                   delegate:self
    //                                          cancelButtonTitle:NSLocalizedString(@"Cancel",nil)
    //                                          otherButtonTitles:NSLocalizedString(@"Helicopter Size & Beginner Settings",nil),NSLocalizedString(@"Swashplate Parameter",nil), NSLocalizedString(@"Tail Parameter",nil),NSLocalizedString(@"Nitro Governor Parameter",nil), nil];
    [_alert show];
}

- (void) alertView:(UIAlertView *)alertView clickedButtonAtIndex:(NSInteger)buttonIndex{
    _buttonNext.enabled=YES;
    _buttonBack.enabled=YES;
    CGRect frame = ttScrollSlidingPagesController.bottomScrollView.frame;
    frame.origin.y = 0;
    
    if (buttonIndex == 0) {
        return;
    }
    
    if ((buttonIndex - 1) == 0) {
        _buttonBack.enabled=NO;
    }else if ((buttonIndex - 1) == ([_pages count] - 1)){
        _buttonNext.enabled=NO;
    }
    
    frame.origin.x = frame.size.width * (buttonIndex-1);
    ttScrollSlidingPagesController.pageControl.currentPage=buttonIndex-1;
    [ttScrollSlidingPagesController.bottomScrollView scrollRectToVisible:frame animated:YES];
    
}

- (IBAction)buttonNext:(id)sender{
    
    if (ttScrollSlidingPagesController.pageControl.currentPage+1 == ttScrollSlidingPagesController.pageControl.numberOfPages)
        return;
    
    long page =(ttScrollSlidingPagesController.pageControl.currentPage+1)%ttScrollSlidingPagesController.pageControl.numberOfPages;
    
    CGRect frame = ttScrollSlidingPagesController.bottomScrollView.frame;
    frame.origin.x = frame.size.width * page;
    frame.origin.y = 0;
    
    [ttScrollSlidingPagesController.bottomScrollView scrollRectToVisible:frame animated:YES];
    ttScrollSlidingPagesController.pageControl.currentPage = page;
    
    _buttonBack.enabled=YES;
    _buttonNext.enabled=YES;
    if (page == ([_pages count] - 1)) {
        _buttonNext.enabled=NO;
    }
}

-(void)scrollSlidingPagesController:(TTScrollSlidingPagesController *)scrollSlidingPagesController WithPageChange:(NSInteger)page{
    
    _buttonNext.enabled=NO;
    _buttonBack.enabled=NO;
    
    if (page != ([_pages count] - 1)) {
        _buttonNext.enabled=YES;
    }
    if (page != 0) {
        _buttonBack.enabled=YES;
    }
    
}
- (IBAction)aSelector:(id)sender{
    [self.navigationController popToRootViewControllerAnimated:YES];
}

-(void)dealloc{
    if (_alert){
        [_alert dismissWithClickedButtonIndex:0 animated:NO];
    }
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
