//
//  HomeController.m
//  MyWeibo
//
//  Created by ChenXin on 3/2/15.
//  Copyright (c) 2015 ChenXin. All rights reserved.
//

#import "HomeController.h"
#import "UIBarButtonItem+Custom.h"
#import "ButtonWithRightIcon.h"
#import "OAuthInfo.h"
#import "Util.h"
#import "Account.h"
#import "MJExtension.h"
#import "Status.h"
#import "User.h"
#import "UIImageView+WebCache.h"
#import "StatusFrame.h"
#import "StatusCell.h"
#import "StatusPhoto.h"
#import "MJRefresh.h"
#import "HttpTool.h"

@interface HomeController () <MJRefreshBaseViewDelegate>
//微博数据模型
@property(nonatomic, strong) NSArray *status;
//微博数据转换成的Frame模型
@property(nonatomic, strong) NSMutableArray *statusFrames;
//导航栏中间的按钮
@property(nonatomic,weak) ButtonWithRightIcon *navMiddleView;
//归档用户帐户
@property(nonatomic, strong) Account *account;
//上拉刷新view
@property(nonatomic, weak) MJRefreshHeaderView *refreshHeader;
//下拉刷新view
@property(nonatomic, weak) MJRefreshFooterView *refreshFooter;

@end

@implementation HomeController

- (id)initWithStyle:(UITableViewStyle)style
{
    self = [super initWithStyle:style];
    if (self) {
        //初始化微博数据转换成的Frame模型
        self.statusFrames=[NSMutableArray array];
        self.account=[Util getAccount];
    }
    return self;
}

- (void)viewDidLoad
{
    [super viewDidLoad];
    //添加刷新控件
    [self addRefreshView];
    //左边朋友
    self.navigationItem.leftBarButtonItem=[UIBarButtonItem barButtonItemWithIcon:@"navigationbar_friendsearch" hilightIcon:@"navigationbar_friendsearch_highlighted" target:self action:@selector(friendSearch)];
    //右边的扫一扫
    self.navigationItem.rightBarButtonItem=[UIBarButtonItem barButtonItemWithIcon:@"navigationbar_pop" hilightIcon:@"navigationbar_pop_highlighted" target:self action:@selector(friendSearch)];
    //中间按钮
    ButtonWithRightIcon *middleBtn=[[ButtonWithRightIcon alloc] init];
    //如过归档的account有昵称，直接设置，没有通过网络请求
    if (self.account.name) {
        [middleBtn setTitle:self.account.name forState:UIControlStateNormal];
    }else {
        [middleBtn setTitle:@"首页" forState:UIControlStateNormal];
        /**
         *  请求用户数据信息
         */
        [self setupUserData];
    }
    [middleBtn setImage:[UIImage imageWithName:@"navigationbar_arrow_down"] forState:UIControlStateNormal];
    [middleBtn addTarget:self action:@selector(clickMiddleBtn:) forControlEvents:UIControlEventTouchUpInside];
    self.navigationItem.titleView=middleBtn;
    self.navMiddleView=middleBtn;
    //设置tableview的背景颜色
    self.tableView.backgroundColor=MyColor(226,226,226);
    //设置tableview顶部和底部的预留间隙
    self.tableView.contentInset=UIEdgeInsetsMake(GlobalCellMargin, 0, GlobalCellMargin, 0);
    //设置tableview的分割线为空
    self.tableView.separatorStyle=UITableViewCellSeparatorStyleNone;
}

//添加上拉和下拉刷新view
-(void) addRefreshView{
    MJRefreshFooterView *refreshFooter=[[MJRefreshFooterView alloc] init];
    refreshFooter.scrollView=self.tableView;
    refreshFooter.delegate=self;
    self.refreshFooter=refreshFooter;
    
    MJRefreshHeaderView *refreshHeader=[[MJRefreshHeaderView alloc] init];
    refreshHeader.scrollView=self.tableView;
    refreshHeader.delegate=self;
    [refreshHeader beginRefreshing];
    self.refreshHeader=refreshHeader;
}
/**
 *  开始刷新，用于外部调用
 */
-(void) beginRefreshStatus{
    //如果是首页清空tabItem上的徽标
    self.tabBarItem.badgeValue=0;
    [self.refreshHeader beginRefreshing];
}

//开始刷新处理方法
-(void)refreshViewBeginRefreshing:(MJRefreshBaseView *)refreshView{
    if ([refreshView isKindOfClass:[MJRefreshFooterView class]]) {
        [self loadMoreStatusData];
    }else {
        [self loadNewStatusData];
    }
}
/**
 *  下拉刷新数据
 */
-(void) loadNewStatusData{
    Account *account=[Util getAccount];
    NSMutableDictionary *parameters=[NSMutableDictionary dictionary];
    parameters[@"source"]=AppKey;
    parameters[@"access_token"]=account.access_token;
    if (self.statusFrames.count) {
        StatusFrame *sf=self.statusFrames[0];
        parameters[@"since_id"]=sf.status.idstr;
    }
    [HttpTool getURL:StatusDataURL parameter:parameters success:^(id responseObject) {
        NSArray *jsonArray=responseObject[@"statuses"];
        //json对象转换成微博数据模型
        NSArray *statusData=[Status objectArrayWithKeyValuesArray:jsonArray];
        //根据微博数据模型构造微博的Frame模型
        NSMutableArray *tempFrames=[NSMutableArray array];
        for (Status *st in statusData) {
            StatusFrame *statusFrame=[[StatusFrame alloc] init];
            statusFrame.status=st;
            [tempFrames addObject:statusFrame];
        }
        //[self.statusFrames addObjectsFromArray:tempFrames];
        if (self.statusFrames.count) {
            [self.statusFrames insertObjects:tempFrames atIndexes:[NSIndexSet indexSetWithIndexesInRange:NSMakeRange(0, tempFrames.count)]];
        }else{
            [self.statusFrames addObjectsFromArray:tempFrames];
        }
        
        [self.tableView reloadData];
        [self.refreshHeader endRefreshing];
        //显示刷新提示
        [self showRefreshTipView:tempFrames.count];
    } faile:^(NSError *error) {
        [self.refreshHeader endRefreshing];
    }];
}
/**
 *  上啦加载更多数据
 */
-(void) loadMoreStatusData{
    Account *account=[Util getAccount];
    NSMutableDictionary *parameters=[NSMutableDictionary dictionary];
    parameters[@"source"]=AppKey;
    parameters[@"access_token"]=account.access_token;
    if (self.statusFrames.count) {
        StatusFrame *sf=[self.statusFrames lastObject];
        parameters[@"max_id"]=@([sf.status.idstr longLongValue]-1);
    }
    
    [HttpTool getURL:StatusDataURL parameter:parameters success:^(id responseObject) {
        NSArray *jsonArray=responseObject[@"statuses"];
        //json对象转换成微博数据模型
        NSArray *statusData=[Status objectArrayWithKeyValuesArray:jsonArray];
        //根据微博数据模型构造微博的Frame模型
        NSMutableArray *tempFrames=[NSMutableArray array];
        for (Status *st in statusData) {
            StatusFrame *statusFrame=[[StatusFrame alloc] init];
            statusFrame.status=st;
            [tempFrames addObject:statusFrame];
        }
        
        [self.statusFrames addObjectsFromArray:tempFrames];
        
        [self.tableView reloadData];
        [self.refreshFooter endRefreshing];
        //显示刷新提示
        [self showRefreshTipView:tempFrames.count];
    } faile:^(NSError *error) {
        [self.refreshFooter endRefreshing];
    }];
    
}

/**
 *  请求用户数据信息
 */
-(void) setupUserData{
    Account *account=[Util getAccount];
    NSMutableDictionary *parameters=[NSMutableDictionary dictionary];
    parameters[@"source"]=AppKey;
    parameters[@"access_token"]=account.access_token;
    parameters[@"uid"]=@(account.uid);
    [HttpTool getURL:UserDataURL parameter:parameters success:^(id responseObject) {
        User *user=[User objectWithKeyValues:responseObject];
        //设置用户昵称
        account.name=user.name;
        //归档Account对象
        [Util saveAccount:account];
        [self.navMiddleView setTitle:user.name forState:UIControlStateNormal];
    } faile:^(NSError *error) {
        
    }];
    
}

//显示刷新提示动画显示
-(void) showRefreshTipView:(int) count{
    UIButton *tipView=[[UIButton alloc] init];
    [tipView setBackgroundImage:[UIImage imageResize:@"timeline_new_status_background"] forState:UIControlStateNormal];
    [tipView setTitle:[NSString stringWithFormat:@"更新%d条微博",count] forState:UIControlStateNormal];
    [tipView setTitleColor:[UIColor orangeColor] forState:UIControlStateNormal];
    tipView.titleLabel.font=[UIFont systemFontOfSize:13.5];
    CGFloat h=34.0;
    CGFloat x=0;
    CGFloat y=CGRectGetMaxY(self.navigationController.navigationBar.frame)-h;
    tipView.frame=CGRectMake(x, y, self.view.frame.size.width, h);
    [self.navigationController.view insertSubview:tipView belowSubview:self.navigationController.navigationBar];
    [UIView animateWithDuration:0.7 animations:^{
        //向下动画显示
        tipView.transform=CGAffineTransformMakeTranslation(0, h);
    } completion:^(BOOL finished) {
        //完成后恢复，移除提示view
        [UIView animateWithDuration:0.7 delay:1.0 options:UIViewAnimationOptionCurveLinear animations:^{
            tipView.transform=CGAffineTransformIdentity;
        } completion:^(BOOL finished) {
            [tipView removeFromSuperview];
        }];
    }];
}

-(void) friendSearch{
    NSLog(@"friendSearch");
}
-(void) clickMiddleBtn:(UIButton *) button{
    
}


- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}


- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section
{
    return self.statusFrames.count;
}


- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
    static NSString *identifer=@"MyCel111l";
    StatusCell *cell = [tableView dequeueReusableCellWithIdentifier:identifer];
    if (cell==nil) {
        cell=[[StatusCell alloc] initWithStyle:UITableViewCellStyleSubtitle reuseIdentifier:identifer];
    }
    StatusFrame *sf=self.statusFrames[indexPath.row];
    cell.statusFrame=sf;
    return cell;
}

-(CGFloat) tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath{
    StatusFrame *sf=self.statusFrames[indexPath.row];
    return sf.cellHight;
}

-(void)dealloc{
    [self.refreshFooter free];
    [self.refreshHeader free];
}
@end
