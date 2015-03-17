//
//  StatusToolBar.m
//  MyWeibo
//
//  Created by ChenXin on 3/17/15.
//  Copyright (c) 2015 ChenXin. All rights reserved.
//  自定义微博底部工具栏

#import "StatusToolBar.h"

@interface StatusToolBar ()
//按钮item的数组
@property(nonatomic, strong) NSMutableArray *items;
//图片分割线数组
@property(nonatomic, strong) NSMutableArray *splites;

@end

@implementation StatusToolBar

- (id)initWithFrame:(CGRect)frame
{
    self = [super initWithFrame:frame];
    if (self) {
        //设置底部工具栏中到按钮
        UIButton *retweet=[self setupToolBarItem:@"转发" image:@"timeline_icon_retweet" bgImage:@"timeline_card_leftbottom_highlighted"];
        UIButton *comment=[self setupToolBarItem:@"评论" image:@"timeline_icon_comment" bgImage:@"timeline_card_middlebottom_highlighted"];
        UIButton *like=[self setupToolBarItem:@"赞" image:@"timeline_icon_unlike" bgImage:@"timeline_card_rightbottom_highlighted"];
        [self addSubview:retweet];
        [self addSubview:comment];
        [self addSubview:like];
        //设置分割图片
        UIImageView *splite1=[self setupSpliteView];
        UIImageView *splite2=[self setupSpliteView];
        [self addSubview:splite1];
        [self addSubview:splite2];
        //设置允许用户交互
        self.userInteractionEnabled=YES;
    }
    return self;
}

/**
 *  设置分割图片view
 */
-(UIImageView *) setupSpliteView{
    UIImageView *imageView=[[UIImageView alloc] initWithImage:[UIImage imageWithName:@""]];
    [self.splites addObject:imageView];
    return imageView;
}

/**
 *  设置底部工具栏的按钮
 *
 *  @param title 按钮标题
 *  @param image 按钮图标
 *  @param bg    higlight背景图片
 *
 *  @return
 */
-(UIButton *) setupToolBarItem:(NSString *) title image:(NSString *) image bgImage:(NSString *) bg{
    UIButton *btn=[[UIButton alloc] init];
    [btn setTitle:title forState:UIControlStateNormal];
    btn.titleLabel.font=[UIFont systemFontOfSize:13];
    [btn setTitleColor:[UIColor grayColor] forState:UIControlStateNormal];
    [btn setImage:[UIImage imageWithName:image] forState:UIControlStateNormal];
    [btn setBackgroundImage:[UIImage imageResize:bg] forState:UIControlStateHighlighted];
    btn.titleEdgeInsets=UIEdgeInsetsMake(0, 5, 0, 0);
    //加入到按钮item数组中，在layoutsubviews使用
    [self.items addObject:btn];
    return btn;
}
/**
 *  懒加载分割线数组
 */
-(NSMutableArray *)splites{
    if (_splites==nil) {
        _splites=[NSMutableArray array];
    }
    return _splites;
}
/**
 *  懒加按钮item数组
 */
-(NSMutableArray *)items{
    if (_items==nil) {
        _items=[NSMutableArray array];
    }
    return _items;
}

-(void)layoutSubviews{
    [super layoutSubviews];
    CGFloat itemY=0;
    CGFloat itemW=self.frame.size.width/self.items.count;
    CGFloat itemH=self.frame.size.height;
    //调整toolbar中到按钮位置
    for (int i=0; i<self.items.count; i++) {
        UIButton *btn=self.items[i];
        btn.frame=CGRectMake(i*itemW, itemY, itemW, itemH);
    }
    CGFloat spliteY=0;
    CGFloat spliteW=2;
    CGFloat spliteH=self.frame.size.height;
    //调整分割图片view到位置
    for (int j=0; j<self.splites.count; j++) {
        UIImageView *splite=self.splites[j];
        splite.frame=CGRectMake((j+1)*itemW, spliteY, spliteW, spliteH);
    }
}

@end
