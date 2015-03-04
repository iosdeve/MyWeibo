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

@interface HomeController ()

@end

@implementation HomeController

- (id)initWithStyle:(UITableViewStyle)style
{
    self = [super initWithStyle:style];
    if (self) {
        // Custom initialization
    }
    return self;
}

- (void)viewDidLoad
{
    [super viewDidLoad];
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
}

-(void) friendSearch{
    NSLog(@"friendSearch");
}

-(void) clickMiddleBtn:(ButtonWithRightIcon *) btn{
    if (btn.imageView.image==[UIImage imageWithName:@"navigationbar_arrow_down"]) {
        [btn setImage:[UIImage imageWithName:@"navigationbar_arrow_up"] forState:UIControlStateNormal];
    }else{
        [btn setImage:[UIImage imageWithName:@"navigationbar_arrow_down"] forState:UIControlStateNormal];
    }
}

- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

#pragma mark - Table view data source

- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView
{
#warning Potentially incomplete method implementation.
    // Return the number of sections.
    return 0;
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section
{
#warning Incomplete method implementation.
    // Return the number of rows in the section.
    return 0;
}

/*
- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
    UITableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:<#@"reuseIdentifier"#> forIndexPath:indexPath];
    
    // Configure the cell...
    
    return cell;
}
*/

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
