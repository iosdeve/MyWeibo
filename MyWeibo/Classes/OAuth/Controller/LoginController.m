//
//  LoginController.m
//  MyWeibo
//
//  Created by ChenXin on 3/5/15.
//  Copyright (c) 2015 ChenXin. All rights reserved.
// 登录界面

#import "LoginController.h"
#import "AFNetworking.h"
#import "Account.h"

@interface LoginController () <UIWebViewDelegate>
@property(nonatomic, strong) AFHTTPRequestOperationManager *requestManager;
@end

@implementation LoginController

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
    //设置webView
    [self setupWebView];
}

/**
 *  设置webView
 */
-(void) setupWebView{
    UIWebView *webView=[[UIWebView alloc] init];
    webView.frame=CGRectMake(0, 0, self.view.frame.size.width, self.view.frame.size.height);
    NSString *url=[NSString stringWithFormat:@"%@?client_id=%@&redirect_uri=%@",OAuthURL,AppKey,@"http://m.baidu.com"];
    [webView loadRequest:[NSURLRequest requestWithURL:[NSURL URLWithString:url]]];
    webView.delegate=self;
    [self.view addSubview:webView];
}
/**
 *  是否向服务器发送请求
 *
 *  @param webView
 *  @param request        request的url
 *  @param navigationType <#navigationType description#>
 *
 *  @return 如果返回NO，则不发送请求
 */
-(BOOL)webView:(UIWebView *)webView shouldStartLoadWithRequest:(NSURLRequest *)request navigationType:(UIWebViewNavigationType)navigationType{
    //获取请求URL地址
    NSString *url=request.URL.absoluteString;
    //截取accessToken
    NSRange range=[url rangeOfString:@"code="];
    NSString *accessToken=nil;
    if (range.location!=NSNotFound) {
        accessToken=[url substringFromIndex:range.location+range.length];
        //创建请求管理类
        self.requestManager=[AFHTTPRequestOperationManager manager];
        //设置服务器响应解析类型位JSON
        self.requestManager.responseSerializer=[AFJSONResponseSerializer serializer];
        NSMutableDictionary *parameters=[NSMutableDictionary dictionary];
        parameters[@"client_id"]=AppKey;
        parameters[@"client_secret"]=AppSecret;
        parameters[@"grant_type"]=@"authorization_code";
        parameters[@"code"]=accessToken;
        parameters[@"redirect_uri"]=@"http://m.baidu.com";
        //发送Post请求
        [self.requestManager POST:AccessTokenURL parameters:parameters success:^(AFHTTPRequestOperation *operation, id responseObject) {
            Account *account=[Account accountFromeDict:responseObject];
            NSString *archivePath=[DocumentPath stringByAppendingPathComponent:@"account.data"];
            [NSKeyedArchiver archiveRootObject:account toFile:archivePath];
        } failure:^(AFHTTPRequestOperation *operation, NSError *error) {
            NSLog(@"--%@",error);
        }];
    }
    return YES;
}


@end
