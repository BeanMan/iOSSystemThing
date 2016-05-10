//
//  ViewController.m
//  iOSSystemThing
//
//  Created by bean on 16/5/10.
//  Copyright © 2016年 com.xile. All rights reserved.
//

#import "ViewController.h"
#import <Social/Social.h> //第二个按钮需要 导入苹果自带分享的头文件,社交分享需要
#import "MenuLB.h"//第三个按钮需要
@interface ViewController ()
{
    UISlider * slider;//第四个按钮需要
}

@end

@implementation ViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    
    NSArray * arr = @[@"分享",@"社交分享",@"复制粘贴",@"屏幕亮度"];
    
    for (int i = 0; i<arr.count; i++)
    {
        UIButton * btn = [UIButton buttonWithType:UIButtonTypeCustom];
        btn.frame = CGRectMake(80*i, 40, 70, 100);
        btn.backgroundColor = [UIColor redColor];
        [btn addTarget:self action:@selector(click:) forControlEvents:UIControlEventTouchUpInside];
        btn.titleLabel.font = [UIFont systemFontOfSize:15];
        [btn setTitle:arr[i] forState:UIControlStateNormal];
        [self.view addSubview:btn];
        btn.tag = i + 1;
    }
}





-(void)click:(UIButton*)btn
{
    switch (btn.tag) {
        case 1:
        {
            [self shareImessage];
        }
            break;
        case 2:
        {
            [self shareSocial];
        }
            break;
        case 3:
        {
            [self jianceCut];
        }
            break;
        case 4:
        {
            [self ligtht];
        }
            break;
        default:
            break;
    }
    

}



-(void)shareImessage
{
    NSString *info = @"分享文字";
    
    UIImage *image=[UIImage imageNamed:@"1"];//分享的图片
    NSURL *url = [NSURL URLWithString:@"http://www.google.com"];//分享的链接
    NSArray *postItems=@[info, image, url];
    
    UIActivityViewController *controller = [[UIActivityViewController alloc] initWithActivityItems:postItems applicationActivities:nil];
    
    [self presentViewController:controller animated:YES completion:nil];
}


-(void)shareSocial
{
    //【注】如果手机没有设置相关社交账号打开下面注释的话不能掉起分享
    // 1.判断平台是否可用(系统没有集成,用户设置账号)
    //    if (![SLComposeViewController isAvailableForServiceType:SLServiceTypeSinaWeibo])
    //    {
    //        NSLog(@"设置界面设置自己的账号");
    //        return;
    //    }   //必须要用户在设置中设置了账号
    
    
    /**
     SOCIAL_EXTERN NSString *const SLServiceTypeTwitter NS_AVAILABLE(10_8, 6_0);
     SOCIAL_EXTERN NSString *const SLServiceTypeFacebook NS_AVAILABLE(10_8, 6_0);
     SOCIAL_EXTERN NSString *const SLServiceTypeSinaWeibo NS_AVAILABLE(10_8, 6_0);
     SOCIAL_EXTERN NSString *const SLServiceTypeTencentWeibo NS_AVAILABLE(10_9, 7_0);
     SOCIAL_EXTERN NSString *const SLServiceTypeLinkedIn NS_AVAILABLE(10_9, NA);
     
     */
    
    // 2.创建分享控制器
    SLComposeViewController *composeVc = [SLComposeViewController composeViewControllerForServiceType:SLServiceTypeSinaWeibo];
    
    // 2.1.添加分享的文字
    [composeVc setInitialText:@"梦想还是要有的,万一实现了呢"];
    
    // 2.2.添加分享的图片
    [composeVc addImage:[UIImage imageNamed:@"1"]];
    
    // 3.弹出控制器进行分享
    [self presentViewController:composeVc animated:YES completion:nil];
    
    // 4.设置监听发送结果
    composeVc.completionHandler = ^(SLComposeViewControllerResult reulst) {
        if (reulst == SLComposeViewControllerResultDone)
        {
            NSLog(@"用户发送成功");
        } else {
            NSLog(@"用户发送失败");
        }
    };
}


-(void)jianceCut
{
    //----------------------------------------------------
    //当然系统提供的menuItem的标题，默认是英文的，我们可以设置menu支持中文，显示中文 ->修改软件应用支持中文
    //----------------------------------------------------
    
    MenuLB * lb = [[MenuLB alloc]initWithFrame:CGRectMake(100, 250, 65, 65)];
    lb.userInteractionEnabled = YES;
    lb.backgroundColor = [UIColor redColor];
    lb.text = @"点我点我";
    lb.textAlignment = 1;
    lb.font = [UIFont systemFontOfSize:15];
    [self.view addSubview:lb];
}

-(void)ligtht
{
    slider = [[UISlider alloc]initWithFrame:CGRectMake(100, 330, 100, 100)];
    [slider addTarget:self action:@selector(slider:) forControlEvents:UIControlEventValueChanged];
    
    //设置最大值
    slider.maximumValue = 1;
    
    //设置最小值
    slider.minimumValue = 0.2;
    
    //初始值设为1
    //若设置最大值就在右边，设置最小值就在左边
    slider.value = [UIScreen mainScreen].brightness;//设置初始值是屏幕亮度值
    
    
    [self.view addSubview:slider];
}
-(void)slider:(UISlider*)slider2
{
    // 设置系统屏幕亮度
    //    [UIScreen mainScreen].brightness = slider2.value;
    // 或者
    [[UIScreen mainScreen] setBrightness:slider2.value];
}
@end
