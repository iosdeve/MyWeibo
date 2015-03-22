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
#import "ComposeToolBar.h"

@interface ComposeController () <ComposeToolBarDelegate,UINavigationControllerDelegate, UIImagePickerControllerDelegate>
//发微博输入框
@property(nonatomic, weak) ComposeTextView *composeTextView;
//发微博到工具栏
@property(nonatomic, weak) ComposeToolBar *toolBar;

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
    //如果包含图片
    if ([[self.composeTextView getPhotos] count]>0) {
        [self submitStatusWithPhotoToServer];
    }else{
        [self submitStatusToServer];
    }
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

/**
 *  提交带图片的微博内容到服务器
 */
-(void) submitStatusWithPhotoToServer{
    Account *account=[Util getAccount];
    AFHTTPRequestOperationManager *requestManager=[AFHTTPRequestOperationManager manager];
    requestManager.responseSerializer=[AFJSONResponseSerializer serializer];
    NSMutableDictionary *parameters=[NSMutableDictionary dictionary];
    parameters[@"source"]=AppKey;
    parameters[@"access_token"]=account.access_token;
    parameters[@"status"]=self.composeTextView.text;
    
    [requestManager POST:SubmitStatusPhotoURL parameters:parameters constructingBodyWithBlock:^(id<AFMultipartFormData> formData) {
        NSArray *images=[self.composeTextView getPhotos];
        for (int i=0; i<images.count; i++) {
            UIImage *image=images[i];
            [formData appendPartWithFileData:UIImageJPEGRepresentation(image, 0.5) name:@"pic" fileName:[NSString stringWithFormat:@"%d.jpg",i] mimeType:@"image/jpeg"];
        }
        
    } success:^(AFHTTPRequestOperation *operation, id responseObject) {
        [MBProgressHUD showSuccess:@"发送成功"];
    } failure:^(AFHTTPRequestOperation *operation, NSError *error) {
        [MBProgressHUD showError:@"发送失败"];
    }];
}


- (void)viewDidLoad
{
    [super viewDidLoad];
    //添加并设置发微博输入框
    [self setupTextView];
    //添加并设置输入tool bar
    [self setupToolBar];
}
/**
 *  添加并设置发微博输入框
 */
-(void) setupTextView{
    ComposeTextView *composeTextView=[[ComposeTextView alloc] init];
    composeTextView.frame=self.view.bounds;
    composeTextView.placeholder=@"请在此处写你要发送的微博...";
    composeTextView.font=[UIFont systemFontOfSize:14.0];
    [self.view addSubview:composeTextView];
    self.composeTextView=composeTextView;
    //为评论文本改变注册通知
    [[NSNotificationCenter defaultCenter] addObserver:self selector:@selector(composeTextChanged) name:UITextViewTextDidChangeNotification object:composeTextView];
}

//添加并设置输入tool bar
-(void)setupToolBar{
    ComposeToolBar *toolBar=[[ComposeToolBar alloc] init];
    CGFloat x=0;
    CGFloat y=self.view.frame.size.height-44.0;
    toolBar.frame=CGRectMake(x, y, self.view.frame.size.width, 44.0);
    [self.view addSubview:toolBar];
    self.toolBar=toolBar;
    self.toolBar.delegate=self;
    
    //为键盘注册观察者，键盘的frame发生改变d时候接收通知，用于移动tool bar的位置
    [[NSNotificationCenter defaultCenter] addObserver:self selector:@selector(keyBoardFrameDidChange:) name:UIKeyboardWillChangeFrameNotification object:nil];
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
//键盘的frame发生改变时候接收通知，用于移动tool bar的位置
-(void) keyBoardFrameDidChange:(NSNotification *) notify{
    //原来键盘的frame
    CGRect beginFrame=[notify.userInfo[UIKeyboardFrameBeginUserInfoKey] CGRectValue];
    //改变后的键盘frame
    CGRect endFrame=[notify.userInfo[UIKeyboardFrameEndUserInfoKey] CGRectValue];
    //键盘显示过程中的动画时间
    double duration=[notify.userInfo[UIKeyboardAnimationDurationUserInfoKey] doubleValue];
    //如果键盘是从隐藏到显示
    if (beginFrame.origin.y>endFrame.origin.y) {
        [UIView animateWithDuration:duration animations:^{
            self.toolBar.transform=CGAffineTransformMakeTranslation(0, endFrame.origin.y-beginFrame.origin.y);
        }];
    }else{
        //从显示到隐藏
        [UIView animateWithDuration:duration animations:^{
            self.toolBar.transform=CGAffineTransformIdentity;
        }];
    }
}

-(void)composeToolBar:(ComposeToolBar *)toolBar clickButtonType:(ComposeToolBarButtonType)buttonType{
    if (buttonType==ComposeToolBarButtonTypeAlbum) {
        UIImagePickerController *pickerVC=[[UIImagePickerController alloc] init];
        pickerVC.sourceType=UIImagePickerControllerSourceTypePhotoLibrary;
        pickerVC.delegate=self;
        [self presentViewController:pickerVC animated:YES completion:nil];
        
    }else if(buttonType==ComposeToolBarButtonTypeCamera){
        
    }else if(buttonType==ComposeToolBarButtonTypeMetion){
        
    }else if(buttonType==ComposeToolBarButtonTypeTrend){
        
    }else if(buttonType==ComposeToolBarButtonTypeEmoticon){
        
    }
}

-(void)imagePickerController:(UIImagePickerController *)picker didFinishPickingMediaWithInfo:(NSDictionary *)info{
    UIImage *image=info[UIImagePickerControllerOriginalImage];
    self.composeTextView.picture=image;
    [self dismissViewControllerAnimated:YES completion:nil];
}

-(void)viewDidAppear:(BOOL)animated{
    [super viewDidAppear:animated];
    //界面显示的时候自动弹出键盘
//    [self.composeTextView becomeFirstResponder];
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
