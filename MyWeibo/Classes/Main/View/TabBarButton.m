//
//  TabBarButton.m
//  MyWeibo
//
//  Created by ChenXin on 3/2/15.
//  Copyright (c) 2015 ChenXin. All rights reserved.
// 自定义TabBarButton按钮

#import "TabBarButton.h"
#import "BadgeButton.h"

#define TitleSelectedColor iOS7? MyColor(238, 122, 9) : MyColor(248, 161, 21)
#define TitleNormalColor iOS7? [UIColor blackColor] : [UIColor whiteColor]

#define ImageIconHRatio 0.6

@interface TabBarButton ()
@property(nonatomic, weak) BadgeButton *badgeBtn;
@end

@implementation TabBarButton

- (id)initWithFrame:(CGRect)frame
{
    self = [super initWithFrame:frame];
    if (self) {
        //设置item图标居中
        self.imageView.contentMode=UIViewContentModeCenter;
        //设置item文字大小
        self.titleLabel.font=[UIFont systemFontOfSize:12.0];
        //设置item文字居中对齐
        self.titleLabel.textAlignment=NSTextAlignmentCenter;
        //设置item文字被选中时的颜色
        [self setTitleColor:TitleSelectedColor forState:UIControlStateSelected];
        //设置item文字正常时的颜色
        [self setTitleColor:TitleNormalColor forState:UIControlStateNormal];
        //设置item被选中时的背景
        if (!iOS7) {
            [self setBackgroundImage:[UIImage imageWithName:@"tabbar_slider"] forState:UIControlStateSelected];
        }
        //添加徽标按钮
        BadgeButton *badgeBtn=[[BadgeButton alloc] init];
        [self addSubview:badgeBtn];
        self.badgeBtn=badgeBtn;
    }
    return self;
}
//覆盖父类方法，让按钮点击时不出现高亮效果
-(void)setHighlighted:(BOOL)highlighted{};

/**
 *  包含有TabBarItem，用来设置按钮图标和文字
 *
 *  @param item ;
 */
-(void)setItem:(UITabBarItem *)item{
    _item=item;
    [self setupItem];
    //KVO监听徽标值的变化，注册观察者
    [item addObserver:self forKeyPath:@"badgeValue" options:0 context:nil];
    [item addObserver:self forKeyPath:@"title" options:0 context:nil];
    [item addObserver:self forKeyPath:@"image" options:0 context:nil];
    [item addObserver:self forKeyPath:@"selectedImage" options:0 context:nil];
}

/**
 *  设置item文字，图标，徽标
 */
-(void)setupItem{
    [self setTitle:self.item.title forState:UIControlStateNormal];
    [self setTitle:self.item.title forState:UIControlStateSelected];
    [self setImage:self.item.image forState:UIControlStateNormal];
    [self setImage:self.item.selectedImage forState:UIControlStateSelected];
    //设置徽标的直
    self.badgeBtn.badgeValue=self.item.badgeValue;
}

/**
 *  接收item变化的通知
 *
 *  @param keyPath 变化的键值路径
 *  @param object  变化的对象
 *  @param change  change description
 *  @param context
 */
-(void)observeValueForKeyPath:(NSString *)keyPath ofObject:(id)object change:(NSDictionary *)change context:(void *)context{
    //设置item文字，图标，徽标
    [self setupItem];
}

/**
 *  button有frame之后才可以计算徽标的位置
 *  所以重写setFrame方法
 *  @param frame ;
 */
-(void)setFrame:(CGRect)frame{
    [super setFrame:frame];
    //设置徽标X是父控件宽度一般＋10，并且y下移2
    CGFloat badgeX=frame.size.width/2+10;
    self.badgeBtn.frame=CGRectMake(badgeX, 2, self.badgeBtn.bounds.size.width, self.badgeBtn.bounds.size.height);
}

/**
 *  自定义图标frame
 */
-(CGRect)imageRectForContentRect:(CGRect)contentRect{
    CGFloat x=0;
    CGFloat y=2;
    CGFloat w=contentRect.size.width;
    CGFloat h=contentRect.size.height*ImageIconHRatio;
    return CGRectMake(x, y, w, h);
}

/**
 *  自定义文字的frame
 */
-(CGRect)titleRectForContentRect:(CGRect)contentRect{
    CGFloat x=0;
    CGFloat y=contentRect.size.height*ImageIconHRatio-3;
    CGFloat w=contentRect.size.width;
    CGFloat h=contentRect.size.height-y;
    return CGRectMake(x, y, w, h);
}

-(void)dealloc{
    //当对象销毁时，移除观察者
    [self removeObserver:self.item forKeyPath:@"title"];
    [self removeObserver:self.item forKeyPath:@"image"];
    [self removeObserver:self.item forKeyPath:@"selectedImage"];
    [self removeObserver:self.item forKeyPath:@"badgeValue"];
}

@end
