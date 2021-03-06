//
//  ZYNewFeatureViewController.m
//  ZYDoubs
//
//  Created by Momo on 17/1/10.
//  Copyright © 2017年 Momo. All rights reserved.
//

#import "ZYNewFeatureViewController.h"

NSString *const NewFeatureVersionKey = @"NewFeatureVersionKey";

//=================================================
//============== CoreArchive ======================
//=================================================
@interface CoreArchive : NSObject
/**
 *  保存普通字符串
 */
+ (void)setStr:(NSString *)str key:(NSString *)key;

/**
 *  读取
 */
+ (NSString *)strForKey:(NSString *)key;

@end

@implementation CoreArchive
// 保存普通对象
+ (void)setStr:(NSString *)str key:(NSString *)key{
    
    // 获取preference
    NSUserDefaults *defaults = [NSUserDefaults standardUserDefaults];
    
    // 保存
    [defaults setObject:str forKey:key];
    
    // 立即同步
    [defaults synchronize];
    
}

// 读取
+ (NSString *)strForKey:(NSString *)key{
    
    //获取preference
    NSUserDefaults *defaults = [NSUserDefaults standardUserDefaults];
    
    //读取
    NSString *str=(NSString *)[defaults objectForKey:key];
    
    return str;
    
}

@end

@interface ZYNewFeatureViewController ()

@end

@implementation ZYNewFeatureViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
    
    [self createSubview];
}


-(void)createSubview{
    
    UILabel * lab_Thanks = [[UILabel alloc] init];
    lab_Thanks.text = @"感谢你们来看我儿子！";
    [self.view addSubview:lab_Thanks];
    
    [lab_Thanks mas_makeConstraints:^(MASConstraintMaker *make) {
        make.center.equalTo(self.view);
        make.height.equalTo(@40);
        make.width.equalTo(@(ScreenWidth));
    }];
    
    UIButton * btn_enter = [[UIButton alloc]init];
    [btn_enter addTarget:self action:@selector(btnClick) forControlEvents:UIControlEventTouchUpInside];
    btn_enter.titleLabel.font = MiddleFont;
    btn_enter.layer.cornerRadius = 8;
    [btn_enter setTitle:@"进去看看" forState:UIControlStateNormal];
    btn_enter.backgroundColor = MainColor;
    [self.view addSubview:btn_enter];
    
    [btn_enter mas_makeConstraints:^(MASConstraintMaker *make) {
        make.centerX.equalTo(self.view);
        make.top.equalTo(lab_Thanks.mas_bottom).with.offset(15);
        make.width.equalTo(@100);
        make.height.equalTo(@30);
    }];
}

-(void)btnClick{
    
    if (self.lastOnePlayFinished) {
        self.lastOnePlayFinished();
    }
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

#pragma mark - Public Method

// 是否应该显示版本新特性页面
+ (BOOL)canShowNewFeature{
    
    //系统直接读取的版本号
    NSString *versionValueStringForSystemNow=[[NSBundle mainBundle].infoDictionary valueForKey:(NSString *)kCFBundleVersionKey];
    
    //读取本地版本号
    NSString *versionLocal = [CoreArchive strForKey:NewFeatureVersionKey];
    
    if(versionLocal!=nil && [versionValueStringForSystemNow isEqualToString:versionLocal]){//说明有本地版本记录，且和当前系统版本一致
        
        return NO;
        
    }else{ // 无本地版本记录或本地版本记录与当前系统版本不一致
        
        //保存
        [CoreArchive setStr:versionValueStringForSystemNow key:NewFeatureVersionKey];
        
        return YES;
    }
}

@end
