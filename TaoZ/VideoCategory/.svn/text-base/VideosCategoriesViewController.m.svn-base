//
//  VideosCategoriesViewController.m
//  TaoZ
//
//  Created by xudeliang on 13-5-24.
//  Copyright (c) 2013年 陶朱网络. All rights reserved.
//

#import "VideosCategoriesViewController.h"
#import "md5Change.h"
#import "VideoClient.h"
#import "VideosCategoryesListViewController.h"
#import "UIViewController+HideTabBar.h"
#import "ALTabBarController.h"
int imageTag = 1234;
int labelTag = 1235;
@interface VideosCategoriesViewController ()

@end

@implementation VideosCategoriesViewController

- (id)initWithNibName:(NSString *)nibNameOrNil bundle:(NSBundle *)nibBundleOrNil
{
    self = [super initWithNibName:nibNameOrNil bundle:nibBundleOrNil];
    if (self) {
        // Custom initialization
    }
    return self;
}
-(void)viewWillAppear:(BOOL)animated
{
    ALTabBarController *tab = (ALTabBarController *)self.tabBarController;
    [tab hideExistingTabBar];
}
- (void)viewDidLoad
{
    [super viewDidLoad];
    self.navigationItem.title = @"视频";
    mVideoCategoryArray = [[NSMutableArray alloc] init];
    [self getVideoCategory];
//    UIScrollView *abc = [[UIScrollView alloc] initWithFrame:CGRectMake(0, 0, 320, 1200)];
//    [abc setContentSize:CGSizeMake(320,4000 + 10)];
//    abc.delegate =self;
//    UIButton *typeButton = [[UIButton alloc] init];
//    [typeButton setFrame:CGRectMake(100,340, 90, 30)];
//    typeButton.backgroundColor = [UIColor grayColor];
//    [abc addSubview:typeButton];
//    
//    abc.backgroundColor = [UIColor redColor];
//    [self.view addSubview:abc];
    
       // Do any additional setup after loading the view from its nib.
}

-(void)getVideoCategory
{
    NSDictionary *dict = [[NSDictionary alloc]init];
    dict = @{@"appkey":[md5Change md5:APPKEY],
             @"pid":@0,
             @"all":@0};
    
    [[VideoClient instance]getVideoCategory:dict success:^(id sender) {
        if (mVideoCategoryArray == nil)
        {
            mVideoCategoryArray = [[NSMutableArray alloc] init];
        }
        [mVideoCategoryArray addObjectsFromArray:[[sender objectForKey:@"datas"] objectForKey:@"lists"]];
       // NSLog(@"mVideoCategoryArray == %@",mVideoCategoryArray);
        [self layoutButton];
    } failure:^(id sender) {
        
    }];
}
- (void)scrollViewDidScroll:(UIScrollView *)scrollView
{
    NSLog(@"1111");
}
-(void)layoutButton
{
    CGRect rect = [[UIScreen mainScreen]bounds];
    int count = [mVideoCategoryArray count];
    /* 判断有多少行 */
	NSInteger nRow = (count % 2 > 0) ? (count / 2 + 1) : (count / 2);

    if (m_pTypeView == nil)
	{
		m_pTypeView = [[UIScrollView alloc] initWithFrame:CGRectMake(0, 0, 320, 200)];
        [m_pTypeView setContentSize:CGSizeMake(320,rect.size.height-112)];
	}
	
	[m_pTypeView setBackgroundColor:[UIColor grayColor]];
    if (nRow>0)
	{
		/* 根据按钮个数来改变view的高度 */
		[m_pTypeView setFrame:CGRectMake(0, 0, 320, rect.size.height-112)];
        [m_pTypeView setContentSize:CGSizeMake(320,81 * nRow + 50)];
	}
	else
	{
		[m_pTypeView setFrame:CGRectMake(0, 0, 320, 0)];
	}
    
	[self.view addSubview:m_pTypeView];
    
    int wi=0;//用于记录是哪个btn，便于赋值
    for (int i = 0; i < nRow; i++)
	{
		for (int j = 0; j < 2;j++)
		{
			if (count > i * 2 + j)
			{
                
				UIButton *typeButton = [[UIButton alloc] initWithFrame:CGRectMake(35 + j * 159, 10 + i * 90, 90, 81)];
                [typeButton setBackgroundColor:[UIColor clearColor]];
                //[typeButton setAlpha:0.0f];
                UIImageView *typeImage = [[UIImageView alloc] init];
                [typeImage setFrame:CGRectMake(0, 0, 90, 81)];
                // [typeImage setImage:[UIImage imageNamed:@"apple.png"]];
                //typeImage.userInteractionEnabled = YES;
				//[typeButton setTitle:[NSString stringWithFormat:@"%d",i * 2 + j]forState:UIControlStateNormal];
				//typeButton.titleLabel.font = [UIFont systemFontOfSize:16.0];
				[typeButton setTag:i * 2 + j];
                [typeButton addTarget:self  action:@selector(buttonPressed:) forControlEvents:UIControlEventTouchUpInside];
                [typeButton addSubview:typeImage];
				[m_pTypeView addSubview:typeButton];
                NSURL *typeUrl = [NSURL URLWithString:[[mVideoCategoryArray objectAtIndex:wi] objectForKey:@"pic_url"]];
                [typeImage setImageWithURL:typeUrl];

                wi++;

			}
		}
	}

    
	/* 先设置显示分类按钮的视图为隐藏状态 */
	//[m_pTypeView setHidden:YES];

}
-(IBAction)buttonPressed:(id)sender
{
    UIButton *btn = (UIButton *)sender;
 
    [btn setBackgroundImage:[UIImage imageNamed:@"videoCategoryDown.png"] forState:UIControlStateHighlighted];

    NSString *catID = [[mVideoCategoryArray objectAtIndex:btn.tag]objectForKey:@"id"];
    VideosCategoryesListViewController *list = [[VideosCategoryesListViewController alloc] initWithVideoID:catID];
    [list setHidesBottomBarWhenPushed:YES];
    [self.navigationController pushViewController:list animated:YES];
    
    

}
- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

@end
