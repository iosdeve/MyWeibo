//
//  ComposeController.m
//  MyWeibo
//
//  Created by ChenXin on 3/20/15.
//  Copyright (c) 2015 ChenXin. All rights reserved.
//  发表评论的控制器

#import "ComposeController.h"
#import "ComposeTextView.h"
#import "Account.h"
#import "Util.h"
#import "AFNetworking.h"
#import "MBProgressHUD+MJ.h"

@interface ComposeController ()
//发微博输入框
@property(nonatomic, weak) ComposeTextView *composeTextView;

@end

@implementation ComposeController

- (id)initWithNibName:(NSString *)nibNameOrNil bundle:(NSBundle *)nibBundleOrNil
{
    self = [super initWithNibName:nibNameOrNil bundle:nibBundleOrNil];
    if (self) {
        self.navigationItem.leftBarButtonItem=[[UIBarButtonItem alloc] initWithTitle:@"取消" style:UIBarButtonItemStylePlain target:self action:@selector(cancel)];
        self.navigationItem.rightBarButtonItem=[[UIBarButtonItem alloc] initWithTitle:@"发表" style:UIBarButtonItemStyleDone target:self action:@selector(submit)];
    }
    return self;
}

/**
 *  取消发微博
 */
-(void) cancel{
    [self dismissViewControllerAnimated:YES completion:nil];
}
//提交微博内容到服务器
-(void) submit{
    [self submitStatusToServer];
    [self dismissViewControllerAnimated:YES completion:nil];
}

/**
 *  提交微博内容到服务器
 */
-(void) submitStatusToServer{
    Account *account=[Util getAccount];
    AFHTTPRequestOperationManager *requestManager=[AFHTTPRequestOperationManager manager];
    requestManager.responseSerializer=[AFJSONResponseSerializer serializer];
    NSMutableDictionary *parameters=[NSMutableDictionary dictionary];
    parameters[@"source"]=AppKey;
    parameters[@"access_token"]=account.access_token;
    parameters[@"status"]=self.composeTextView.text;
    [requestManager POST:SubmitStatusURL parameters:parameters success:^(AFHTTPRequestOperation *operation, id responseObject) {
        [MBProgressHUD showSuccess:@"发送成功"];
    } failure:^(AFHTTPRequestOperation *operation, NSError *error) {
        [MBProgressHUD showError:@"发送失败"];
    }];
    
}


- (void)viewDidLoad
{
    [super viewDidLoad];
    [self setupTextView];
}
/**
 *  添加并设置发微博输入框
 */
-(void) setupTextView{
    ComposeTextView *composeTextView=[[ComposeTextView alloc] init];
    composeTextView.frame=self.view.bounds;
    [self.view addSubview:composeTextView];
    self.composeTextView=composeTextView;
    //为评论文本改变注册通知
    [[NSNotificationCenter defaultCenter] addObserver:self selector:@selector(composeTextChanged) name:UITextViewTextDidChangeNotification object:composeTextView];
}
//评论文本改变时调用此方法
-(void) composeTextChanged{
    //当没有输入任何文字时，右上角当发表按钮设置为不可用
    if (self.composeTextView.text.length==0) {
        self.navigationItem.rightBarButtonItem.enabled=NO;
    }else{
        self.navigationItem.rightBarButtonItem.enabled=YES;
    }
}

-(void)viewDidAppear:(BOOL)animated{
    [super viewDidAppear:animated];
    //界面显示的时候自动弹出键盘
    [self.composeTextView becomeFirstResponder];
    //注意要在此处设置disable，否则预设到disable字体颜色不生效，don't know why
    self.navigationItem.rightBarButtonItem.enabled=NO;
}

- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

-(void)dealloc{
    //移除观察者，释放内存
    [[NSNotificationCenter defaultCenter] removeObserver:self];
}

@end
