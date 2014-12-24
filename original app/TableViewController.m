//
//  TableViewController.m
//  original app
//
//  Created by ia on 2014/09/05.
//  Copyright (c) 2014年 Life is tech. All rights reserved.
//

#import "TableViewController.h"
#import "WebViewController.h"

#pragma mark - yuma_fix
#import "WebItem.h"
#import "AppDelegate.h"

@interface TableViewController ()
{
    NSMutableArray *yumaArray;
    NSArray *webArray;
    //NSArray *array;
    
}

@end

@implementation TableViewController

- (instancetype)initWithStyle:(UITableViewStyle)style
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
    
    
    [self setNavigationBarTitleImage:[UIImage imageNamed:@"vétements-logo.png"]];
    
    NSUserDefaults *userDefault = [NSUserDefaults standardUserDefaults];
    NSData *array = [userDefault dataForKey:@"webSite"];
    yumaArray = [NSKeyedUnarchiver unarchiveObjectWithData:array];
    if (yumaArray.count <=7) {
     
    
#pragma mark yuma_fix
    yumaArray = [NSMutableArray array];
    WebItem *item1 = [[WebItem alloc] init];
    item1.title = @"DIHOLIC";
    item1.urlString = @"http://www.dholic.co.jp/Nshopping/Shopping_New.asp";
    [yumaArray addObject:item1];
    
    WebItem *item2 = [[WebItem alloc] init];
    item2.title = @"Victoria's Secret";
    item2.urlString = @"https://www.victoriassecret.com/";
    [yumaArray addObject:item2];
    
    WebItem *item3 = [[WebItem alloc] init];
    item3.title = @"ehyphen";
    item3.urlString = @"http://www.ehyphen.jp/";
    [yumaArray addObject:item3];
    
    WebItem *item4 = [[WebItem alloc] init];
    item4.title = @"H&M";
    item4.urlString = @"http://www.hm.com/jp/";
    [yumaArray addObject:item4];
    
    WebItem *item5 = [[WebItem alloc] init];
    item5.title = @"AMERICAN EAGLE";
    item5.urlString = @"http://www.aeo.jp/top/CSfTop.jsp?gclid=COWQ5MGFr8ECFZYGvAodpm8AAA";
    [yumaArray addObject:item5];
    
    WebItem *item6 = [[WebItem alloc] init];
    item6.title = @"GAP";
    item6.urlString = @"http://www.gap.co.jp/?tid=gjps009609";
    [yumaArray addObject:item6];
    
    WebItem *item7 = [[WebItem alloc] init];
    item7.title = @"Foever 21";
    item7.urlString = @"http://www.forever21.co.jp/?gclid=CI2mjsOGr8ECFRBwvAodNV0AhA#";
    [yumaArray addObject:item7];
        
        NSData *data =[NSKeyedArchiver archivedDataWithRootObject:yumaArray];
        NSUserDefaults *defaults = [NSUserDefaults standardUserDefaults];
        [defaults setObject:data forKey:@"webSite"];

    }
    
    UIBarButtonItem *addLinkButton = [[UIBarButtonItem alloc] initWithImage:[[UIImage imageNamed:@"add4.png"] imageWithRenderingMode:UIImageRenderingModeAlwaysOriginal]
                                                             style:UIBarButtonItemStylePlain
                                                            target:self
                                                            action:@selector(addLinkButtonTap)];
    self.navigationItem.rightBarButtonItem = addLinkButton;
    
    
    
    
    
    UIFont *font = [UIFont fontWithName:@"HelveticaNeue-Bold" size:10.0f];
    //タブ選択時のフォントとカラー
    NSDictionary *selectedAttributes = @{NSFontAttributeName : font,
                                         NSForegroundColorAttributeName : [UIColor redColor]};
    
    [[UITabBarItem appearance] setTitleTextAttributes:selectedAttributes
                                             forState:UIControlStateSelected];
    
    //通常時のフォントとカラー
    NSDictionary *attributesNormal = @{NSFontAttributeName : font,
                                       NSForegroundColorAttributeName : [UIColor blueColor]};
    
    [[UITabBarItem appearance] setTitleTextAttributes:attributesNormal
                                             forState:UIControlStateNormal];
    
    
    
    
    
}
- (void)setNavigationBarTitleImage:(UIImage *)image
{
    UIImageView *titleImageView = [[UIImageView alloc] initWithImage:image];
    // Adjust Image Size
    titleImageView.frame = CGRectMake(0, 0, image.size.width * 0.5, image.size.height * 0.5);
    
    UIView *titleView = [[UIView alloc]initWithFrame:CGRectMake(-image.size.width*0.5, 0, titleImageView.frame.size.width , titleImageView.frame.size.height)];
    [titleView addSubview:titleImageView];
    self.navigationItem.titleView = titleView;
}

- (void)viewWillAppear:(BOOL)animated{
    [super viewWillAppear:animated];//viewWillAppearは毎回必ず、何回でもよばれる。viewdidloadの次によばれる
    if (self.tabBarController.tabBar.hidden == YES) {//もしtabBarController.tabBar.hiddenがYESだったら
        self.tabBarController.tabBar.hidden = NO;//tabBarController.tabBar.hiddenをNOにする
      

    }
}

-(IBAction)addLinkButtonTap{
    //アラートを表示す
    UIAlertView *message = [[UIAlertView alloc] initWithTitle:@"Enter File Details"
                                                      message:nil
                                                     delegate:self
                                            cancelButtonTitle:@"Cancel"
                                            otherButtonTitles:@"Add", nil];
    
    [message setAlertViewStyle:UIAlertViewStyleLoginAndPasswordInput];
    UITextField *fileDescription = [message textFieldAtIndex:0];
    fileDescription.placeholder=@"title";
    [[message textFieldAtIndex:1]setSecureTextEntry:NO];
    UITextField *fileName= [message textFieldAtIndex:1];
    fileName.placeholder=@"url";
    
    [message show];
    
    
    
}
    


-(void)alertView:(UIAlertView *)alertView clickedButtonAtIndex:(NSInteger)buttonIndex
{
    if (buttonIndex == 1) {
        NSString *titleStr = [[alertView textFieldAtIndex:0] text];
        NSString *urlStr = [[alertView textFieldAtIndex:1] text];
        
        WebItem *item = [[WebItem alloc] init];
        item.title = titleStr;
        item.urlString = urlStr;
        [yumaArray addObject:item];
        [self.tableView reloadData];
        
        NSData *data = [NSKeyedArchiver archivedDataWithRootObject:yumaArray];
        //NSData *data [NSKeyedArchived archievedDataWithRootObject:yumaArray];//archieved
        NSUserDefaults *defaults  = [NSUserDefaults standardUserDefaults];
        [defaults setObject:data forKey:@"webSite"];
        [defaults synchronize]; // 即時保存(UserDefaultsは、すぐに保存されない)
        
        NSLog(@"%@", [defaults objectForKey:@"webSite"]);
        
        
    }
}

/*-(void)tableView:(UITableView *)tableView didDeselectRowAtIndexPath:(NSIndexPath *)indexPath
{
    [tableView deselectRowAtIndexPath:indexPath animated:YES];
    
    //先にデータソースを削除する
    [yumaArray removeObjectAtIndex:indexPath.row];
    
    NSArray *deleteArray = [NSArray arrayWithObject:indexPath];
    //UITableViewの行を消去する
    [tableView deleteRowsAtIndexPaths:deleteArray withRowAnimation:UITableViewRowAnimationAutomatic];

}*/




- (BOOL)tableView:(UITableView *)tableView canEditRowAtIndexPath:(NSIndexPath *)indexPath
{
    // Return NO if you do not want the specified item to be editable.
    return YES;
}

//TableViewのcellをdelete
-(void)tableView:(UITableView *)tableView commitEditingStyle:(UITableViewCellEditingStyle)editingStyle forRowAtIndexPath:(NSIndexPath *)indexPath
{
    if (editingStyle == UITableViewCellEditingStyleDelete) {
        // Delete the row from the data source
        [yumaArray removeObjectAtIndex:indexPath.row];
        NSUserDefaults *userDefaults = [NSUserDefaults standardUserDefaults];
        NSData *data = [NSKeyedArchiver archivedDataWithRootObject:yumaArray];
        //NSData *data [NSKeyedArchived archievedDataWithRootObject:yumaArray];//archieved
        NSUserDefaults *defaults  = [NSUserDefaults standardUserDefaults];
        [defaults setObject:data forKey:@"webSite"];
        [userDefaults synchronize]; // 即時保存(UserDefaultsは、すぐに保存されない)
        [tableView deleteRowsAtIndexPaths:@[indexPath] withRowAnimation:UITableViewRowAnimationFade];
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
    //#warning Potentially incomplete method implementation.
    // Return the number of sections.
    return 1;
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section
{
    //#warning Incomplete method implementation.
    // Return the number of rows in the section.
    return yumaArray.count;//列の数
}


- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
    UITableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:@"Cell" forIndexPath:indexPath];
       // Configure the cell...
    // cell.contentView.backgroundColor = [UIColor redColor];
    
#pragma mark yuma_fix
    WebItem *item = yumaArray[indexPath.row];
    cell.textLabel.text = [NSString stringWithFormat:@"%@", item.title];
    
    return cell;
}

-(void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath
{
    WebViewController *vc = [self.storyboard instantiateViewControllerWithIdentifier:@"WebController"];
    
#pragma mark yuma_fix
    WebItem *item = yumaArray[indexPath.row];
    vc.urlString = item.urlString;
    
    self.tabBarController.tabBar.hidden= YES;
    [self.navigationController pushViewController:vc animated:YES];
    [self.tableView deselectRowAtIndexPath:indexPath animated:YES];
}





/*- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath {
 //セル選択状態の解除
 [tableView deselectRowAtIndexPath:indexPath animated:YES];
 //ここにやりたいことを書く
 NSURL *url = [NSURL URLWithString:@"http://cookpad.com/"];
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
                        
