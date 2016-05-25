//
//  DMIntroductionViewController.m
//  HRGuideView
//
//  Created by linxiu on 16/5/24.
//  Copyright © 2016年 甘真辉. All rights reserved.
//

#import "DMIntroductionViewController.h"
#import "DMPageControlView.h"
#import "RootTabViewController.h"

#define DMRGB(r, g, b) [UIColor colorWithRed:(r)/255.f green:(g)/255.f blue:(b)/255.f alpha:1.f]
#define DMNavgationColor DMRGB(240, 77, 77)      //导航颜色及主色
@interface DMIntroductionViewController ()<UIScrollViewDelegate,UIGestureRecognizerDelegate>

@property (nonatomic, strong) DMPageControlView *pageControlView;
@property (nonatomic, strong) UIButton *nextBt;
@property (nonatomic, strong) UIScrollView *scrollView;
@property (nonatomic, assign) int n;

@end

@implementation DMIntroductionViewController


    
- (NSString *)imageKeyForIndex:(NSInteger)index{
    return [NSString stringWithFormat:@"%ld_image", (long)index];
}

- (NSString *)viewKeyForIndex:(NSInteger)index{
    return [NSString stringWithFormat:@"%ld_view", (long)index];
}
- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
 self.view.backgroundColor = [UIColor lightGrayColor];
  
    NSArray *iconImageArray;
    NSArray *tipsArray;
    iconImageArray=[NSArray arrayWithObjects:@"intro_icon_0",@"intro_icon_1",@"intro_icon_2",@"intro_icon_3",@"intro_icon_4",@"intro_icon_5",@"intro_icon_6",nil];
//    tipsArray = [NSArray arrayWithObjects:@"intro_tip_0",@"intro_tip_1",@"intro_tip_2",@"intro_tip_3",@"intro_tip_4",@"intro_tip_5",@"intro_tip_6", nil];
    // scrollView
    self.scrollView = [[UIScrollView alloc]initWithFrame:CGRectMake(0, 0, self.view.frame.size.width, self.view.frame.size.height)];
    
    _scrollView.contentSize = CGSizeMake(self.view.frame.size.width*iconImageArray.count, self.view.frame.size.height);
    _scrollView.pagingEnabled = YES;
    _scrollView.showsHorizontalScrollIndicator = NO; //是否显示水平滚动条
    _scrollView.delegate = self;
    
//    [self.view addSubview:_scrollView];
    
   for (int i = 0; i<iconImageArray.count; i++) {
        UIImageView *imageView = [[UIImageView alloc]initWithFrame:CGRectMake(i*self.view.frame.size.width, 0, self.view.frame.size.width, self.view.frame.size.height)];
        imageView.image = [UIImage imageNamed:iconImageArray[i]];
        [self.scrollView addSubview:imageView];
        
        if (i==iconImageArray.count-1) {
            imageView.userInteractionEnabled = YES;
            
            CGFloat w = 227;
            CGFloat x = (self.view.frame.size.width-w)/2;
            self.nextBt = [[UIButton alloc]initWithFrame:CGRectMake(x, self.view.frame.size.height*480/560, self.view.frame.size.width-x*2, 44) ];
            _nextBt.layer.masksToBounds = YES;
            _nextBt.layer.borderColor = DMRGB(255, 255, 255).CGColor;
            _nextBt.layer.borderWidth = 0.5;
            _nextBt.layer.cornerRadius = 22;
            [_nextBt.titleLabel setFont:[UIFont boldSystemFontOfSize:21]];
            [_nextBt setTitle:@"开启首页之旅" forState:UIControlStateNormal];
            [_nextBt addTarget:self action:@selector(gotoAction) forControlEvents:UIControlEventTouchUpInside];
            [_nextBt addTarget:self action:@selector(changefontAction) forControlEvents:UIControlEventTouchDown];
            [_nextBt setTitleColor:[UIColor blueColor] forState:UIControlStateNormal];
            [_nextBt addTarget:self action:@selector(reductionAction) forControlEvents:UIControlEventTouchDragOutside];
            
            [imageView addSubview:self.nextBt];

        }
        
        
    }
    
     [self.view addSubview:_scrollView];
    //    PageControl
    //    UIImage *pageIndicatorImage = [UIImage imageNamed:@"intro_dot_unselected"];
    //    UIImage *currentPageIndicatorImage = [UIImage imageNamed:@"intro_dot_selected"];
    
    //点击滑动按键
    self.pageControlView = [[DMPageControlView alloc]initWithFrame:CGRectMake(0,self.view.frame.size.height-50, self.view.frame.size.width, 30)];
    _pageControlView.currentPagePointColor = DMNavgationColor;
    _pageControlView.pagePointColor = [UIColor whiteColor];
    _pageControlView.PointSize = 12.0f;
    _pageControlView.distanceOfPoint = 20.0f;
    [_pageControlView setNumberOfPages:iconImageArray.count];
    
    [self.view addSubview:_pageControlView];
}

-(void)scrollViewDidScroll:(UIScrollView *)scrollView
{
    CGPoint  offset = scrollView.contentOffset;
    
    CGFloat index = offset.x/(scrollView.frame.size.width);
    int n = (int)index;
    if (index - n > 0.5) {
        self.n = n + 1;
    }
    else
    {
        self.n = n;
    }
    
    [_pageControlView setCurrentPage:self.n];
    
    if (index > 5) {
        _pageControlView.hidden = YES;
    }
    else
    {
        _pageControlView.hidden = NO;
    }
}

#pragma mark - 回到主页
-(void)gotoAction
{
    NSLog(@"heh");
    
    [self.view removeFromSuperview];
    //写入数据
    NSUserDefaults * setting = [NSUserDefaults standardUserDefaults];
    NSString * key = [NSString stringWithFormat:@"is_first"];
    [setting setObject:[NSString stringWithFormat:@"false"] forKey:key];
    [setting synchronize];
    
    RootTabViewController *tab = [[RootTabViewController alloc]init];
    [UIApplication sharedApplication].delegate.window.rootViewController = tab;
}
#pragma mark - Orientations
- (BOOL)shouldAutorotate{
    return UIInterfaceOrientationIsLandscape(self.preferredInterfaceOrientationForPresentation);
}

- (UIInterfaceOrientation)preferredInterfaceOrientationForPresentation {
    return UIInterfaceOrientationPortrait;
}

- (UIInterfaceOrientationMask)supportedInterfaceOrientations {
    return UIInterfaceOrientationMaskPortrait;
}

- (void)forceChangeToOrientation:(UIInterfaceOrientation)interfaceOrientation{
    [[UIDevice currentDevice] setValue:[NSNumber numberWithInteger:interfaceOrientation] forKey:@"orientation"];
}
#pragma mark - 字体变小
-(void)changefontAction
{
    [_nextBt.titleLabel setFont:[UIFont boldSystemFontOfSize:20]];
}

#pragma mark - 字体变小
-(void)reductionAction
{
    [_nextBt.titleLabel setFont:[UIFont boldSystemFontOfSize:21]];
}
@end
