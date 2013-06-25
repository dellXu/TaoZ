//
//  MyAccountEditMailViewController.m
//  TaoZ
//
//  Created by xudeliang on 13-6-20.
//  Copyright (c) 2013年 陶朱网络. All rights reserved.
//

#import "MyAccountEditMailViewController.h"

@interface MyAccountEditMailViewController ()

@end

@implementation MyAccountEditMailViewController

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
    [self layOutSelfView];
	// Do any additional setup after loading the view.
}
-(void)layOutSelfView
{
    self.navigationItem.title = @"修改邮箱";
    
    UIButton *backBtn = [[UIButton alloc]initWithFrame:CGRectMake(0, 0, 33, 27)];
    [backBtn setBackgroundImage:[UIImage imageNamed:@"NavBack1.png"] forState:UIControlStateNormal];
    [backBtn setBackgroundImage:[UIImage imageNamed:@"NavBack2.png"] forState:UIControlStateHighlighted];
    [backBtn addTarget:self action:@selector(backBtnPressed) forControlEvents:UIControlEventTouchUpInside];
    UIBarButtonItem*it = [[UIBarButtonItem alloc]initWithCustomView:backBtn];
    self.navigationItem.leftBarButtonItem = it;
    
    self.view.backgroundColor =[UIColor colorWithRed:240.0f/255.0f green:239.0f/255.0f blue:235.0f/255.0f alpha:1.0f];
    UIImageView *img = [[UIImageView alloc]init];
    [img setFrame:CGRectMake(11, 15, 297, 40)];
    img.image = [UIImage imageNamed:@"myTaozloginCell.png"];
    img.userInteractionEnabled = YES;
    [self.view addSubview:img];
    
    UILabel *nameLabel = [[UILabel alloc]initWithFrame:CGRectMake(0, 0, 50, 40)];
    nameLabel.text = @"  邮箱:";
    nameLabel.backgroundColor = [UIColor clearColor];
    [img addSubview:nameLabel];
    
    UITextField *nameTextField = [[UITextField alloc]initWithFrame:CGRectMake(55, 0, 242, 40)];
    [nameTextField setBorderStyle:UITextBorderStyleNone];
    nameTextField.backgroundColor = [UIColor clearColor];
    [nameTextField becomeFirstResponder];
    nameTextField.text = @"12312313@qq.com";
    nameTextField.clearButtonMode = UITextFieldViewModeAlways;
    nameTextField.contentVerticalAlignment = UIControlContentVerticalAlignmentCenter;
    [img addSubview:nameTextField];
    
    UIButton *finishBtn = [[UIButton alloc]initWithFrame:CGRectMake(0, 0, 112, 42)];
    [finishBtn setCenter:CGPointMake(160, 110)];
    [finishBtn setBackgroundImage:[UIImage imageNamed:@"MyAccountFinish2.png"] forState:UIControlStateNormal];
    [finishBtn setBackgroundImage:[UIImage imageNamed:@"MyAccountFinish1.png"] forState:UIControlStateHighlighted];
    [finishBtn setTitleColor:[UIColor whiteColor] forState:UIControlStateNormal];
    [finishBtn setTitle:@"完成" forState:UIControlStateNormal];
    finishBtn.titleLabel.font = [UIFont boldSystemFontOfSize:20.0f];;
    [self.view addSubview: finishBtn];
}

-(void)backBtnPressed
{
    [self.navigationController popViewControllerAnimated:YES];
}
- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

@end
