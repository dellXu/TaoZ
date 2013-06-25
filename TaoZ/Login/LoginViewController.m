//
//  LoginViewController.m
//  TaoZ
//
//  Created by xudeliang on 13-5-15.
//  Copyright (c) 2013年 陶朱网络. All rights reserved.
//

#import "LoginViewController.h"
#import "UIViewController+HideTabBar.h"
#import "RegisteredUsersViewController.h"
#import "UIViewController+ErrorUI.h"
#import "SDBlocks.h"
#import "SDClient.h"
#import "md5Change.h"
#import "getUserInfo.h"
#import "ALTabBarController.h"
#import "RetrievePasswordViewController.h"
#import <TencentOpenAPI/TencentOAuth.h>


#define DBNAME      @"taoz.sqlite"
#define TABLENAME   @"userInfo"
#define USERID      @"userID"
@interface LoginViewController ()
@property(nonatomic,strong)TencentOAuth *tencentOAuth;
@property(nonatomic,strong)NSMutableArray* permissions;
@property(nonatomic,strong)NSString *tencentToken;
@property(nonatomic,strong)NSString *tencentOpenId;
@property(nonatomic,copy)NSDictionary *userinfoDic;
@end

@implementation LoginViewController

- (id)initWithNibName:(NSString *)nibNameOrNil bundle:(NSBundle *)nibBundleOrNil
{
    self = [super initWithNibName:nibNameOrNil bundle:nibBundleOrNil];
    if (self) {
        // Custom initialization
    }
    return self;
}
-(void)viewWillAppear:(BOOL)animated {
    ALTabBarController *tab = (ALTabBarController *)self.tabBarController;
    [tab hideTabBar];
}

- (void)viewDidLoad
{
    [super viewDidLoad];
     NSString *appid = @"100449483";
    self.tencentOAuth = [[TencentOAuth alloc] initWithAppId:appid
    andDelegate:self];
    _permissions = [NSArray arrayWithObjects:
                     kOPEN_PERMISSION_GET_USER_INFO,
                     kOPEN_PERMISSION_GET_SIMPLE_USER_INFO,
                     kOPEN_PERMISSION_ADD_ALBUM,
                     kOPEN_PERMISSION_ADD_IDOL,
                     kOPEN_PERMISSION_ADD_ONE_BLOG,
                     kOPEN_PERMISSION_ADD_PIC_T,
                     kOPEN_PERMISSION_ADD_SHARE,
                     kOPEN_PERMISSION_ADD_TOPIC,
                     kOPEN_PERMISSION_CHECK_PAGE_FANS,
                     kOPEN_PERMISSION_DEL_IDOL,
                     kOPEN_PERMISSION_DEL_T,
                     kOPEN_PERMISSION_GET_FANSLIST,
                     kOPEN_PERMISSION_GET_IDOLLIST,
                     kOPEN_PERMISSION_GET_INFO,
                     kOPEN_PERMISSION_GET_OTHER_INFO,
                     kOPEN_PERMISSION_GET_REPOST_LIST,
                     kOPEN_PERMISSION_LIST_ALBUM,
                     kOPEN_PERMISSION_UPLOAD_PIC,
                     kOPEN_PERMISSION_GET_VIP_INFO,
                     kOPEN_PERMISSION_GET_VIP_RICH_INFO,
                     kOPEN_PERMISSION_GET_INTIMATE_FRIENDS_WEIBO,
                     kOPEN_PERMISSION_MATCH_NICK_TIPS_WEIBO,
                     nil];
    self.title = @"我的账号";

    
    [self layOutView];
    // Do any additional setup after loading the view from its nib.
}


-(void)layOutView
{
    UIBarButtonItem *registerItem = [[UIBarButtonItem alloc]initWithTitle:@"注册"
                                                                    style:UIBarButtonItemStylePlain
                                                                   target:self
                                                                   action:@selector(registeredUsers)];
    self.navigationItem.rightBarButtonItem = registerItem;
    
    UIImageView *leftImage = [[UIImageView alloc]initWithImage:[UIImage imageNamed:@"textFieldLeft.png"]];
    UIImageView *rightImage = [[UIImageView alloc]initWithImage:[UIImage imageNamed:@"textFieldLeft.png"]];
    self.mLoginNumberTextField.leftView = leftImage;
    self.mLoginNumberTextField.leftViewMode = UITextFieldViewModeAlways;
    
    self.mLoginPassWordTextField.leftView = rightImage;
    self.mLoginPassWordTextField.leftViewMode = UITextFieldViewModeAlways;

}
/**
 * Called when the user successfully logged in.
 */
- (void)tencentDidLogin {
    if (_tencentOAuth.accessToken && 0 != [_tencentOAuth.accessToken length])
    {
        _tencentToken = _tencentOAuth.accessToken;
        _tencentOpenId = _tencentOAuth.openId;
        [_tencentOAuth getUserInfo];
    }
    else
    {
        NSLog(@"登录不成功 没有获取accesstoken");
    }

}
#pragma mark -
#pragma mark qq登录委托方法
/***********************************************************************
 * 功能描述： 获取用户信息委托方法
 * 输入参数：
 * 输出参数：
 * 返 回 值： 空
 * 其它说明：
 ***********************************************************************/
- (void)getUserInfoResponse:(APIResponse*) response
{
    NSLog(@"----%@ ",response.jsonResponse);
    //获取到用户信息后调用第三方账户登录接口
    NSString *nickname = [response.jsonResponse objectForKey:@"nickname"];
    
    NSDictionary *dict = [[NSDictionary alloc]init];
    dict = @{@"appkey":[md5Change md5:APPKEY],
             @"platform":@"qq",
             @"pid":_tencentOpenId,
             @"nick_name":nickname};

    [[SDClient instance]loginByOtherAccount:dict success:^(NSDictionary *reDict){
        if ([[reDict objectForKey:@"ret"] isEqualToNumber:[NSNumber numberWithInt:1]])
        {
            NSLog(@"user info = %@ ",[dict objectForKey:@"userinfo"]);
        }
    }failure:^(id sender) {
        
    }];

    
}



#pragma mark 打开/创建数据库
-(void)dbOpendatabase
{
    //在ios5系统后，数据库明确要求放在Caches文件夹目录下了。不然审核通不过
    //NSString * documents =[NSSearchPathForDirectoriesInDomains(NSCachesDirectory, NSUserDomainMask,YES) objectAtIndex:0];
    
    NSArray *paths = NSSearchPathForDirectoriesInDomains(NSDocumentDirectory, NSUserDomainMask, YES);
    NSString *documents = [paths objectAtIndex:0];
    NSString *database_path = [documents stringByAppendingPathComponent:DBNAME];
    //open database
    if (sqlite3_open([database_path UTF8String], &db) != SQLITE_OK)
    {
        sqlite3_close(db);
        NSLog(@"数据库打开失败");
        return;
    }
    //create table
    NSString *sqlCreateTable = @"CREATE TABLE IF NOT EXISTS userInfo (userID INTEGER PRIMARY KEY AUTOINCREMENT)";
    [self execSql:sqlCreateTable];
}

//用户登录，插入userID为防止数据重复，先删除要插入的数据，然后再插入数据 
-(void)dbLoginIn:(NSInteger)userid
{
    //预防插入重复数据，先删除表内相关数据（若存在则被删除)
    NSString *sql1 = [NSString stringWithFormat:
                      @"DELETE FROM '%@' WHERE %@ = '%d'",TABLENAME,USERID,userid];
    [self execSql:sql1];
    //插入搜索记录
    NSString *sql2 = [NSString stringWithFormat:
                      @"INSERT INTO '%@' ('%@') VALUES ('%d')",TABLENAME,USERID,userid];
    
    [self execSql:sql2];
    
    
}
//用户退出
-(void)dbLoginOut:(NSInteger)userid
{
    //预防插入重复数据，先删除表内相关数据（若存在则被删除)
    NSString *sql1 = [NSString stringWithFormat:
                      @"DELETE FROM '%@' WHERE %@ = '%d'",TABLENAME,USERID,userid];
    [self execSql:sql1];
}

//获取用户userid
-(void)getUserUserid
{
    int userID = 0;
    NSString *sql1 = [NSString stringWithFormat:
                      @"SELECT userId FROM '%@' ",TABLENAME];
    sqlite3_stmt * statement;
    if (sqlite3_prepare_v2(db, [sql1 UTF8String], -1, &statement, nil) == SQLITE_OK) {
        userID = sqlite3_column_int(statement,0);
        NSLog(@"userID = %d",userID);
    }else
    {
        userID = -1;
    }
}
//执行数据库语句
-(void)execSql:(NSString *)sql
{
    char *err;
    if(sqlite3_exec(db, [sql UTF8String], NULL, NULL, &err) != SQLITE_OK)
    {
        sqlite3_close(db);
        NSLog(@"数据库操作失败");
    }
}







/**
 * Called when the user dismissed the dialog without logging in.
 */
- (void)tencentDidNotLogin:(BOOL)cancelled
{
	
}

/**
 * Called when the notNewWork.
 */
-(void)tencentDidNotNetWork
{

}

/**
 * Called when the logout.
 */
-(void)tencentDidLogout
{

    
}
-(void)registeredUsers
{
    RegisteredUsersViewController *registeredUsersViewController = [[RegisteredUsersViewController alloc] initWithNibName:@"RegisteredUsersViewController" bundle:nil];
    [self.navigationController pushViewController:registeredUsersViewController animated:YES];
}
#pragma mark -
#pragma mark 触摸背景关闭键盘
/***********************************************************************
 * 功能描述： 触摸背景关闭键盘
 * 输入参数：
 * 输出参数：
 * 返 回 值： 空
 * 其它说明：
 ***********************************************************************/
- (void)touchesBegan:(NSSet *)touches withEvent:(UIEvent *)event
{
	[self.mLoginNumberTextField resignFirstResponder];
    [self.mLoginPassWordTextField resignFirstResponder];
}
-(IBAction)TextField_DidEndOnExit:(id)sender
{
    
}

- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}
/***********************************************************************
 * 功能描述：验证信息(登录)
 * 输入参数：
 * 输出参数：
 * 返 回 值：
 * 其它说明：
 ***********************************************************************/
-(void)validate:(NSDictionary *)params success:(SDBlock)success {
    NSMutableArray * errors = [@[] mutableCopy];
    
    NSString * mobile = [params objectForKey:@"accaunt"];
    if (mobile.length == 0) {
        [errors addObject:@"手机号不能为空"];
    }
 
    NSString * pwd = [params objectForKey:@"pw"];
    if (pwd.length == 0) {
        [errors addObject:@"密码不能为空"];
    }
    
    if (errors.count != 0) {
        [self showErrors:errors];
    } else {
        success();
    }
    
}
#pragma make 登录按钮事件
-(IBAction)loginButtonPressed:(id)sender
{
    NSDictionary *dict = [[NSDictionary alloc]init];
    dict = @{@"appkey":[md5Change md5:APPKEY],
             @"accaunt":self.mLoginNumberTextField.text,
             @"pw":[md5Change md5:self.mLoginPassWordTextField.text]};
    [self validate:dict success:^{
        [[SDClient instance]loginByTaozAccount:dict success:^(NSDictionary *reDict){
            self.userinfoDic = reDict;
            if ([[self.userinfoDic objectForKey:@"ret"] isEqualToNumber:[NSNumber numberWithInt:1]])
            {
                //保存用户信息
                int userID = [[[_userinfoDic objectForKey:@"userinfo"] objectForKey:@"id"] intValue];
                NSLog(@"user info = %@ ",[_userinfoDic objectForKey:@"userinfo"]);
                //[self dbOpendatabase];
                //[self dbLoginIn:userID];
                //保存用户信息
                NSDictionary *userinfo = [_userinfoDic objectForKey:@"userinfo"];
                getUserInfo *saveUserinfo =  [[getUserInfo alloc] init];
                [saveUserinfo saveUserinfoTosqlite:userinfo userID:userID userPwd:[md5Change md5:self.mLoginPassWordTextField.text] userAccount:self.mLoginNumberTextField.text];
                [self.navigationController popViewControllerAnimated:YES];
            }
        }failure:^(id sender) {
            
        }];
    }];

    
}
-(IBAction)loginBySinaButtonPressed:(id)sender
{
	
}
-(IBAction)loginByQQButtonPressed:(id)sender
{
    [_tencentOAuth authorize:_permissions inSafari:NO];
}
-(IBAction)forgetButtonPressed:(id)sender
{
    RetrievePasswordViewController *retrievep = [[RetrievePasswordViewController alloc] init];
    [self.navigationController pushViewController:retrievep animated:YES];
}
@end
