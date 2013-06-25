//
//  MyAccountViewController.m
//  TaoZ
//
//  Created by xudeliang on 13-6-18.
//  Copyright (c) 2013年 陶朱网络. All rights reserved.
//

#import "MyAccountViewController.h"
#import "MyAccountInfoCell.h"
#import "MyAccountEditNameViewController.h"
#import "MyAccountEditMailViewController.h"
#import "MyAccountEditPhoneViewController.h"
#import "ALTabBarController.h"
#import "getUserInfo.h"
#import "md5Change.h"
#import "SDClient.h"
@interface MyAccountViewController ()

@end

@implementation MyAccountViewController

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
    [self getUserInfo];
	// Do any additional setup after loading the view.
    [self layOutMyAccountView];
}

-(void)passUserAccountAndPwd:(NSArray *)accountAry
{
    accountAndPwdAry = [NSArray arrayWithArray:accountAry];
}
-(void)getUserInfo
{
    if (accountAndPwdAry.count>0)
    {
        NSDictionary *dict = [[NSDictionary alloc]init];
        dict = @{@"appkey":[md5Change md5:APPKEY],
                 @"accaunt":[accountAndPwdAry objectAtIndex:0],
                 @"pw":[accountAndPwdAry objectAtIndex:1]};
        
        [[SDClient instance]loginByTaozAccount:dict success:^(NSDictionary *reDict){
            if ([[reDict objectForKey:@"ret"] isEqualToNumber:[NSNumber numberWithInt:1]])
            {
                userInfoDic = [[[NSDictionary alloc]initWithDictionary:reDict] objectForKey:@"userinfo"];
                NSLog(@"---userDic-%@",userInfoDic);
            }
        }failure:^(id sender) {
            
        }];
    }else
    {
         [self.view makeToast:@"登录后才能进入我的帐号，请登陆" duration:3.0f position:@"center"];
    }
    
}
-(void)layOutMyAccountView
{
    
    //默认显示个人信息相关界面
    [self layOutPersonInfo];
    //头像上部背景图
    UIImageView *bgImgView = [[UIImageView alloc]initWithImage:[UIImage imageNamed:@"MyAccountImgBg.png"]];
    [bgImgView setFrame:CGRectMake(0, 0, 320, 91)];
    bgImgView.userInteractionEnabled = NO;
    [self.view addSubview:bgImgView];
    
    //昵称
    UILabel *nickName = [[UILabel alloc]initWithFrame:CGRectMake(99, 43, 105, 20)];
    //nickName.text = @"小屁孩Rain";
    nickName.text = [userInfoDic objectForKey:@"lastname"];
    nickName.backgroundColor = [UIColor clearColor];
    nickName.font = [UIFont systemFontOfSize:20];
    nickName.textColor = [UIColor whiteColor];
    [self.view addSubview:nickName];
    //头像背景
    UIImageView *headBtnImg = [[UIImageView alloc]initWithFrame:CGRectMake(11, 43, 74, 74)];
    headBtnImg.image = [UIImage imageNamed:@"MyAccountHeadBg.png"];
    [self.view addSubview:headBtnImg];
    //头像
    UIButton *headBtn = [[UIButton alloc]initWithFrame:CGRectMake(3, 3, 67, 67)];
    [headBtn setBackgroundImage:[UIImage imageNamed:@"MyAccountHead"] forState:UIControlStateNormal];
    [headBtnImg addSubview:headBtn];
    
    //还可观看次数图标
    UIImageView *canPlayImgView = [[UIImageView alloc]initWithImage:[UIImage imageNamed:@"MyAccountCanPlay.png"]];
    [canPlayImgView setFrame:CGRectMake(96, 70, 17, 13)];
    [self.view addSubview:canPlayImgView];
    
    //还可观看次数字样
    UILabel *canPlayLabel = [[UILabel alloc]initWithFrame:CGRectMake(126, 70, 158, 16)];
//    canPlayLabel.text = @"还可观看23条视频";
    canPlayLabel.text = [userInfoDic objectForKey:@"user_money"];
    canPlayLabel.backgroundColor = [UIColor clearColor];
    canPlayLabel.font = [UIFont systemFontOfSize:16];
    canPlayLabel.textColor = [UIColor whiteColor];
    [self.view addSubview:canPlayLabel];
    
    //级别图像
    UIImageView *levelImg = [[UIImageView alloc]initWithFrame:CGRectMake(88, 101, 31, 13)];
    levelImg.image = [UIImage imageNamed:@"level2.png"];
    [self.view addSubview:levelImg];

    //经验值进度条背景
    UIImageView *imageView = [[UIImageView alloc]initWithFrame:CGRectMake(124, 101, 184, 18)];
    imageView.image = [UIImage imageNamed:@"MyAccountProgessBg.png"];
    [self.view addSubview:imageView];
    //经验值进度条
    
    float pro = 0.5f;
    UIImage *image = [UIImage imageNamed:@"MyAccountProgess.png"];
    UIImageView *imageViewIn = [[UIImageView alloc]initWithFrame:CGRectMake(1.5f, 2.0f, 182*pro, 15)];
    //拉伸图片
    CGFloat top = 17; // 顶端盖高度
    CGFloat bottom = 17 ; // 底端盖高度
    CGFloat left = 14; // 左端盖宽度
    CGFloat right = 14; // 右端盖宽度
    UIEdgeInsets insets = UIEdgeInsetsMake(top, left, bottom, right); // 伸缩后重新赋值
    image = [image resizableImageWithCapInsets:insets];
    imageViewIn.image = image;
    [imageView addSubview:imageViewIn];
    
    
    //个人信息，观看纪录，我的收藏
    UIImageView *tabView = [[UIImageView alloc]initWithFrame:CGRectMake(0, 130, 320, 41)];
    tabView.image = [UIImage imageNamed:@"MyAccountTab.png"];
    [self.view addSubview:tabView];
    //个人信息按钮
    UIButton *infoBtn = [[UIButton alloc]initWithFrame:CGRectMake(0, 130, 106, 39)];
    infoBtn.tag = 1100;
    [infoBtn setSelected:YES];
    [infoBtn setBackgroundImage:[UIImage imageNamed:@"MyAccountInfo.png"] forState:UIControlStateSelected];
    [infoBtn addTarget:self action:@selector(tabButtonPressed:) forControlEvents:UIControlEventTouchUpInside];
    [self.view  addSubview:infoBtn];
    
    //观看纪录按钮
    UIButton *playRecordBtn = [[UIButton alloc]initWithFrame:CGRectMake(107, 130, 106, 39)];
    playRecordBtn.tag = 1101;
    [playRecordBtn addTarget:self action:@selector(tabButtonPressed:) forControlEvents:UIControlEventTouchUpInside];
    [self.view  addSubview:playRecordBtn];
    
    //我的收藏按钮
    UIButton *favoriteBtn = [[UIButton alloc]initWithFrame:CGRectMake(215, 130, 106, 39)];
    favoriteBtn.tag = 1102;
    [favoriteBtn addTarget:self action:@selector(tabButtonPressed:) forControlEvents:UIControlEventTouchUpInside];
    [self.view addSubview:favoriteBtn];
}
#pragma mark 绘制个人信息列表
-(void)layOutPersonInfo
{
    //个人信息列表大背景
    CGRect rect = [[UIScreen mainScreen]bounds];

    UITableView *infoTableView = [[UITableView alloc] initWithFrame:CGRectMake(0, 165, 320, rect.size.height-165-60) style:UITableViewStyleGrouped];
    infoTableView.backgroundColor = [UIColor colorWithRed:240.0f/255.0f green:239.0f/255.0f blue:235.0f/255.0f alpha:1.0f];
    infoTableView.backgroundView = nil;
    infoTableView.delegate = self;
    infoTableView.dataSource = self;
    [self.view addSubview:infoTableView];
}


#pragma mark TableView 委托方法
-(CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath
{
    return 44;
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section
{
    if (section == 0)
    {
       return 2; 
    }else if (section == 1)
    {
        return 4;
    }
	return 0;
}
- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView;
{
    return 2;
}
-(void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath
{
    if (indexPath.section == 0)
    {
        //编辑手机号
        if (indexPath.row == 0){
            MyAccountEditPhoneViewController *editPhone = [[MyAccountEditPhoneViewController alloc]init];
            [self.navigationController pushViewController:editPhone animated:YES];
        }else{
        //编辑绑定邮箱
            MyAccountEditMailViewController *editMail = [[MyAccountEditMailViewController alloc] init];
            [self.navigationController pushViewController:editMail animated:YES];
        }
    }
    else if (indexPath.section == 1)
    {
        //编辑姓名
        if (indexPath.row == 0){
            MyAccountEditNameViewController *editName = [[MyAccountEditNameViewController alloc]init];
            [self.navigationController pushViewController:editName animated:YES];
        }else if (indexPath.row == 1){
        //修改性别
            UIAlertView *editSex = [[UIAlertView alloc]initWithTitle:@"修改性别"
                                                             message:nil
                                                            delegate:self
                                                   cancelButtonTitle:@"男"
                                                   otherButtonTitles:@"女", nil];
            [editSex show];
        }else if (indexPath.row == 2){
        //编辑职务
            [self layOutPosition];
        }else if (indexPath.row == 3){
        //编辑生日
            [self layOutDatePicker];
        }
    }
}
- (void)actionSheet:(UIActionSheet *)actionSheet clickedButtonAtIndex:(NSInteger)buttonIndex
{
    NSLog(@"----%d",buttonIndex);
}

#pragma mark 绘制职务列表
-(void)layOutPosition
{
    UIActionSheet *act = [[UIActionSheet alloc]initWithTitle:@"编辑职务"
                                                    delegate:self
                                           cancelButtonTitle:@"取消" destructiveButtonTitle:nil otherButtonTitles:@"董事长/董事",@"总裁/CEO",@"副总裁/VP",@"总经理",@"总监",@"经理",@"核心骨干",@"HR",@"其他", nil];
    act.actionSheetStyle = UIActionSheetStyleDefault;
    [act showInView:[UIApplication sharedApplication].keyWindow];
    //[act showFromTabBar:self.tabBarController.tabBar];
    
}
-(void)layOutDatePicker
{

#if 1
    CGRect rect  = [[UIScreen mainScreen]bounds];

    datePicker = [[UIDatePicker alloc] initWithFrame:CGRectMake(0, rect.size.height-216-60, 320, 216)];
    datePicker.datePickerMode = UIDatePickerModeDate;
    [datePicker addTarget:self action:@selector(dateChangge:) forControlEvents:UIControlEventValueChanged];
    [self.view addSubview:datePicker];
    
    pickerDateToolBar = [[UIToolbar alloc]  initWithFrame:CGRectMake(0.0f, rect.size.height-216-60-44, 320, 44)]; //创建工具条，用来设置或者退出actionsheet.
    pickerDateToolBar.barStyle = UIBarStyleDefault;
    [pickerDateToolBar sizeToFit];
   
    
    UIBarButtonItem *cancelButton =  [[UIBarButtonItem alloc]
                             initWithTitle:@"取消"
                             style:UIBarButtonItemStyleBordered
                             target:self
                              action:@selector(datePickerCancelClick:)];
    
    UIBarButtonItem *doneButton =  [[UIBarButtonItem alloc]
                                      initWithTitle:@"确定"
                                      style:UIBarButtonItemStyleBordered
                                      target:self
                                      action:@selector(datePickerDoneClick:)];
   
    NSMutableArray *barItems = [[NSMutableArray alloc] init];
    //加入flexSpace 使左右2个button分开
    UIBarButtonItem *flexSpace = [[UIBarButtonItem alloc] initWithBarButtonSystemItem:UIBarButtonSystemItemFlexibleSpace target:self action:nil];
    
    [barItems addObject:cancelButton];
    [barItems addObject:flexSpace];
    [barItems addObject:doneButton];
    
    [pickerDateToolBar setItems:barItems animated:YES]; //将按键加入toolbar
    
    [self.view addSubview:pickerDateToolBar];
#endif
}
-(IBAction)dateChangge:(id)sender
{
//    UIDatePicker * control = (UIDatePicker*)sender;
//    NSDate * mYdate = control.date;
//    NSLog(@"date = %@",mYdate);
}
-(IBAction)datePickerCancelClick:(id)sender
{
    [pickerDateToolBar removeFromSuperview];
    pickerDateToolBar = nil;
    [datePicker removeFromSuperview];
    datePicker = nil;
}
-(IBAction)datePickerDoneClick:(id)sender
{

    NSDate * mYdate = datePicker.date;
    NSLog(@"date = %@",mYdate);
    
    [pickerDateToolBar removeFromSuperview];
    pickerDateToolBar = nil;
    [datePicker removeFromSuperview];
    datePicker = nil;
}

-(UITableViewCell*)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
    static NSString *infoTableIdentifier = @"InfoCellIdentifier";
    
    MyAccountInfoCell *cell = (MyAccountInfoCell *)[tableView dequeueReusableCellWithIdentifier:infoTableIdentifier];
    if (cell == nil)
    {
        NSArray *nib = [[NSBundle mainBundle]loadNibNamed:@"MyAccountInfoCell" owner:self options:nil];
        cell = [nib objectAtIndex:0];


        //[cell setBackgroundView:[[UIImageView alloc]initWithImage:[UIImage imageNamed:@"on4.png"]]];//  TabBarBg.png //on4 //myTaozloginCell.png
    }
   if (indexPath.section == 0)
   {
       if (indexPath.row == 0) {
           cell.titleLabel.text = @"手机号码:";
           cell.contectLabel.text = [userInfoDic objectForKey:@"mobile"];
          // cell.markLable.text = @"修改";
           [cell setBackgroundView:[[UIImageView alloc]initWithImage:[UIImage imageNamed:@"MyAccountInfoUp.png"]]];
       }else if (indexPath.row == 1){
           cell.titleLabel.text = @"绑定邮箱:";
           cell.contectLabel.text = [userInfoDic objectForKey:@"email_contact"];
           cell.contectLabel.textColor = [UIColor grayColor];
           [cell setBackgroundView:[[UIImageView alloc]initWithImage:[UIImage imageNamed:@"MyAccountInfoDown.png"]]];
       }
      
   }else if (indexPath.section == 1)
   {
       cell.markLable.hidden = YES;
       if (indexPath.row == 0) {
           cell.titleLabel.text = @"姓名";
           cell.contectLabel.text = @"那谁谁谁";
            [cell setBackgroundView:[[UIImageView alloc]initWithImage:[UIImage imageNamed:@"MyAccountInfoUp.png"]]];
       }else if (indexPath.row == 1){
           cell.titleLabel.text = @"性别";
           cell.contectLabel.text = @"男";
            [cell setBackgroundView:[[UIImageView alloc]initWithImage:[UIImage imageNamed:@"MyAccountInfoMid.png"]]];
       }else if (indexPath.row == 2){
           cell.titleLabel.text = @"职务";
           cell.contectLabel.text = @"总裁";
            [cell setBackgroundView:[[UIImageView alloc]initWithImage:[UIImage imageNamed:@"MyAccountInfoMid.png"]]];
       }else if (indexPath.row == 3){
           cell.titleLabel.text = @"生日";
           cell.contectLabel.text = @"1988-08-08";
            [cell setBackgroundView:[[UIImageView alloc]initWithImage:[UIImage imageNamed:@"MyAccountInfoDown.png"]]];
       }
           
       
   }
    return cell;
    
}




#pragma mark 个人信息，观看纪录，我的收藏按钮点击事件
-(IBAction)tabButtonPressed:(id)sender
{
    UIButton *btn = (UIButton *)sender;
   // btn.selected = !btn.selected;
    if (btn.tag == 1100)//个人信息
    {
         [btn setSelected:YES];
        [btn setBackgroundImage:[UIImage imageNamed:@"MyAccountInfo.png"] forState:UIControlStateSelected];
        UIButton *btnCanPlay = (UIButton *)[self.view viewWithTag:1101];
        [btnCanPlay setSelected:NO];
        UIButton *btnFavorite = (UIButton *)[self.view viewWithTag:1102];
        [btnFavorite setSelected:NO];
    }
    if (btn.tag == 1101)//观看纪录
    {
        [btn setSelected:YES];
        [btn setBackgroundImage:[UIImage imageNamed:@"MyAccountPlayRecord.png"] forState:UIControlStateSelected];
        UIButton *btnInfo = (UIButton *)[self.view viewWithTag:1100];
        [btnInfo setSelected:NO];
        UIButton *btnFavorite = (UIButton *)[self.view viewWithTag:1102];
        [btnFavorite setSelected:NO];
    }
    if (btn.tag == 1102)//观看纪录
    {
        [btn setSelected:YES];
        [btn setBackgroundImage:[UIImage imageNamed:@"MyAccountFavorite.png"] forState:UIControlStateSelected];
        UIButton *btnInfo = (UIButton *)[self.view viewWithTag:1100];
        [btnInfo setSelected:NO];
        UIButton *btnFavorite = (UIButton *)[self.view viewWithTag:1101];
        [btnFavorite setSelected:NO];
    }
}
- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

@end
