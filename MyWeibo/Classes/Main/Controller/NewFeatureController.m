//
//  NewFeatureController.m
//  MyWeibo
//
//  Created by ChenXin on 3/4/15.
//  Copyright (c) 2015 ChenXin. All rights reserved.
//  版本新特性展示

#import "NewFeatureController.h"
#import "CustomTabBarController.h"
#define ImageCount 3

@interface NewFeatureController () <UIScrollViewDelegate>

@property(nonatomic, weak) UIPageControl *pageControl;

@end

@implementation NewFeatureController

- (id)initWithNibName:(NSString *)nibNameOrNil bundle:(NSBundle *)nibBundleOrNil
{
    self = [super initWithNibName:nibNameOrNil bundle:nibBundleOrNil];
    if (self) {
        // Custom initialization
    }
    return self;
}

- (void)viewDidLoad
{
    [super viewDidLoad];
    //设置scrollView
    [self setupScrollView];
    //设置分页指示器
    [self setupPageControlView];
}

/**
 *  设置scrollView
 */
-(void) setupScrollView{
    //添加滚动的scrollview图片
    UIScrollView *scrollView=[[UIScrollView alloc] init];
    CGFloat scrollWidth=self.view.frame.size.width;
    CGFloat scrollHeight=self.view.frame.size.height;
    scrollView.delegate=self;
    scrollView.frame=CGRectMake(0, 0, scrollWidth, scrollHeight);
    //不显示水平滚动条
    scrollView.showsHorizontalScrollIndicator=NO;
    //不是用弹簧效果
    scrollView.bounces=NO;
    //使用分页效果
    scrollView.pagingEnabled=YES;
    //加入图片
    for (int i=0; i<ImageCount; i++) {
        CGFloat x=scrollWidth *i;
        NSString *imageName=[NSString stringWithFormat:@"new_feature_%d",i+1];
        UIImageView *image=[[UIImageView alloc] initWithImage:[UIImage imageWithName:imageName]];
        image.frame=CGRectMake(x, 0, scrollWidth, scrollHeight);
        [scrollView addSubview:image];
        if (ImageCount-1==i) {
            //设置立即分享checkbox和开始微博按钮
            [self setupButtonInImageView:image];
        }
    }
    //设置滚动内容尺寸
    scrollView.contentSize=CGSizeMake(ImageCount*scrollWidth, 0);
    [self.view addSubview:scrollView];
}
/**
 *  设置分页指示器
 */
-(void)setupPageControlView{
    UIPageControl *pageControl=[[UIPageControl alloc] init];
    //设置点点数量
    pageControl.numberOfPages=ImageCount;
    //设置当前点点颜色
    pageControl.currentPageIndicatorTintColor=MyColor(253, 118, 56);
    //设置其他点的颜色
    pageControl.pageIndicatorTintColor=MyColor(201, 201, 201);
    //设置PageControl的位置
    pageControl.bounds=CGRectMake(0, 0, 200, 30);
    pageControl.center=CGPointMake(self.view.frame.size.width/2, self.view.frame.size.height-10);
    [self.view addSubview:pageControl];
    self.pageControl=pageControl;
}

/**
 *  设置立即分享checkbox和开始微博按钮
 */
-(void) setupButtonInImageView:(UIImageView *) imageView{
    imageView.userInteractionEnabled=YES;
    //添加立即开始按钮
    UIButton *startBtn=[UIButton buttonWithType:UIButtonTypeCustom];
    [startBtn setBackgroundImage:[UIImage imageWithName:@"new_feature_finish_button"] forState:UIControlStateNormal];
    startBtn.bounds=CGRectMake(0,0, startBtn.currentBackgroundImage.size.width, startBtn.currentBackgroundImage.size.height);
    startBtn.center=CGPointMake(imageView.frame.size.width/2, imageView.frame.size.height*0.88);
    NSLog(@"%@",NSStringFromCGRect(startBtn.frame));
    [startBtn setTitle:@"立即开始" forState:UIControlStateNormal];
    [startBtn addTarget:self action:@selector(startWeibo:) forControlEvents:UIControlEventTouchUpInside];
    [imageView addSubview:startBtn];
    //添加立即分享checkbox
    UIButton *checkBox=[UIButton buttonWithType:UIButtonTypeCustom];
    [checkBox setImage:[UIImage imageWithName:@"new_feature_share_false"] forState:UIControlStateNormal];
    [checkBox setImage:[UIImage imageWithName:@"new_feature_share_true"] forState:UIControlStateSelected];
    [checkBox setTitle:@"立即分享" forState:UIControlStateNormal];
    checkBox.adjustsImageWhenHighlighted=NO;
    [checkBox setTitleColor:[UIColor blackColor] forState:UIControlStateNormal];
    checkBox.bounds=CGRectMake(0, 0, 200, 35);
    checkBox.center=CGPointMake(imageView.frame.size.width/2, imageView.frame.size.height*0.8);
    [checkBox addTarget:self action:@selector(startShare:) forControlEvents:UIControlEventTouchUpInside];
    [imageView addSubview:checkBox];
}

/**
 *  当scrollView滚动当时候，设置选中当点高亮
 */
-(void)scrollViewDidScroll:(UIScrollView *)scrollView{
    CGFloat offsetX=scrollView.contentOffset.x;
    int index=(offsetX+0.5)/scrollView.frame.size.width;
    self.pageControl.currentPage=index;
}

/**
 *  分享按钮点击事件处理
 */
-(void) startShare:(UIButton *) button{
    button.selected=!button.selected;
}
/**
 *  开始微博按钮点击事件处理
 */
-(void) startWeibo:(UIButton *) button{
    [UIApplication sharedApplication].statusBarHidden=NO;
    [UIApplication sharedApplication].keyWindow.rootViewController=[[CustomTabBarController alloc] init];
}

- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}


@end
