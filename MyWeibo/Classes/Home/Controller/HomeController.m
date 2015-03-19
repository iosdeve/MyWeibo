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
#import "AFNetworking.h"
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

@interface HomeController ()
//微博数据模型
@property(nonatomic, strong) NSArray *status;
//微博数据转换成的Frame模型
@property(nonatomic, strong) NSMutableArray *statusFrames;
//刷新控件
@property(nonatomic, weak) UIRefreshControl *refreshControl;

@end

@implementation HomeController

- (id)initWithStyle:(UITableViewStyle)style
{
    self = [super initWithStyle:style];
    if (self) {
        //初始化微博数据转换成的Frame模型
        self.statusFrames=[NSMutableArray array];
    }
    return self;
}

- (void)viewDidLoad
{
    [super viewDidLoad];
    //添加刷新控件
    [self addRefreshControl];
    //左边朋友
    self.navigationItem.leftBarButtonItem=[UIBarButtonItem barButtonItemWithIcon:@"navigationbar_friendsearch" hilightIcon:@"navigationbar_friendsearch_highlighted" target:self action:@selector(friendSearch)];
    //右边的扫一扫
    self.navigationItem.rightBarButtonItem=[UIBarButtonItem barButtonItemWithIcon:@"navigationbar_pop" hilightIcon:@"navigationbar_pop_highlighted" target:self action:@selector(friendSearch)];
    //中间按钮
    ButtonWithRightIcon *middleBtn=[[ButtonWithRightIcon alloc] init];
    [middleBtn setTitle:@"测试" forState:UIControlStateNormal];
    [middleBtn setImage:[UIImage imageWithName:@"navigationbar_arrow_down"] forState:UIControlStateNormal];
    middleBtn.frame=CGRectMake(0, 0, 80, 38);
    [middleBtn addTarget:self action:@selector(clickMiddleBtn:) forControlEvents:UIControlEventTouchUpInside];
    self.navigationItem.titleView=middleBtn;
    //设置tableview的背景颜色
    self.tableView.backgroundColor=MyColor(226,226,226);
    //设置tableview顶部和底部的预留间隙
//    self.tableView.contentInset=UIEdgeInsetsMake(GlobalCellMargin, 0, GlobalCellMargin, 0);
    //设置tableview的分割线为空
    self.tableView.separatorStyle=UITableViewCellSeparatorStyleNone;
//    [self setupStatusData];
    [self refreshStatusChange:self.refreshControl];
}

-(void) addRefreshControl{
    UIRefreshControl *refreshControl=[[UIRefreshControl alloc] init];
    [self.tableView addSubview:refreshControl];
    [refreshControl addTarget:self action:@selector(refreshStatusChange:) forControlEvents:UIControlEventValueChanged];
    [refreshControl beginRefreshing];
    self.refreshControl=refreshControl;
}

//
-(void) refreshStatusChange:(UIRefreshControl *) refresh{
    [self setupStatusData];
}

-(void) setupStatusData{
    Account *account=[Util getAccount];
    AFHTTPRequestOperationManager *requestManager=[AFHTTPRequestOperationManager manager];
    requestManager.responseSerializer=[AFJSONResponseSerializer serializer];
    NSMutableDictionary *parameters=[NSMutableDictionary dictionary];
    parameters[@"source"]=AppKey;
    parameters[@"access_token"]=account.access_token;
    if (self.statusFrames.count) {
        StatusFrame *sf=self.statusFrames[0];
        parameters[@"since_id"]=sf.status.idstr;
    }
    [requestManager GET:StatusDataURL parameters:parameters success:^(AFHTTPRequestOperation *operation, id responseObject) {
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
        [self.refreshControl endRefreshing];
        //显示刷新提示
        [self showRefreshTipView:tempFrames.count];
    } failure:^(AFHTTPRequestOperation *operation, NSError *error) {
        [self.refreshControl endRefreshing];
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

//- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
//{
//    // 1.创建cell
//    static NSString *ID = @"cell";
//    UITableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:ID];
//    if (cell == nil) {
//        cell = [[UITableViewCell alloc] initWithStyle:UITableViewCellStyleSubtitle reuseIdentifier:ID];
//    }
//    
//    // 2.设置cell的数据
//    // 微博的文字(内容)
//    Status *status = self.status[indexPath.row];
//    cell.textLabel.text = status.text;
//    
//    // 微博作者的昵称
//    User *user = status.user;
//    cell.detailTextLabel.text = user.name;
//    
//    // 微博作者的头像
//    [cell.imageView setImageWithURL:[NSURL URLWithString:user.profile_image_url] placeholderImage:[UIImage imageWithName:@"tabbar_compose_button"]];
//    
//    return cell;
//}


/*
// Override to support conditional editing of the table view.
- (BOOL)tableView:(UITableView *)tableView canEditRowAtIndexPath:(NSIndexPath *)indexPath
{
    // Return NO if you do not want the specified item to be editable.
    return YES;
}
*/

/*
// Override to support editing the table view.
- (void)tableView:(UITableView *)tableView commitEditingStyle:(UITableViewCellEditingStyle)editingStyle forRowAtIndexPath:(NSIndexPath *)indexPath
{
    if (editingStyle == UITableViewCellEditingStyleDelete) {
        // Delete the row from the data source
        [tableView deleteRowsAtIndexPaths:@[indexPath] withRowAnimation:UITableViewRowAnimationFade];
    } else if (editingStyle == UITableViewCellEditingStyleInsert) {
        // Create a new instance of the appropriate class, insert it into the array, and add a new row to the table view
    }   
}
*/

/*
// Override to support rearranging the table view.
- (void)tableView:(UITableView *)tableView moveRowAtIndexPath:(NSIndexPath *)fromIndexPath toIndexPath:(NSIndexPath *)toIndexPath
{
}
*/

/*
// Override to support conditional rearranging of the table view.
- (BOOL)tableView:(UITableView *)tableView canMoveRowAtIndexPath:(NSIndexPath *)indexPath
{
    // Return NO if you do not want the item to be re-orderable.
    return YES;
}
*/

/*
#pragma mark - Navigation

// In a storyboard-based application, you will often want to do a little preparation before navigation
- (void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender
{
    // Get the new view controller using [segue destinationViewController].
    // Pass the selected object to the new view controller.
}
*/

@end
