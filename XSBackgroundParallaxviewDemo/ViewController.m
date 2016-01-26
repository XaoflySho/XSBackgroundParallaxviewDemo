//
//  ViewController.m
//  XSBackgroundParallaxviewDemo
//
//  Created by Xaofly Sho on 16/1/26.
//  Copyright © 2016年 Xaofly Sho. All rights reserved.
//

#import "ViewController.h"
#import "XSBackgroundParallaxView.h"

@interface ViewController ()

@property (nonatomic, strong) IBOutlet XSBackgroundParallaxView *backgroundParallaxView;

@end

@implementation ViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view, typically from a nib.
    
    //设置图片数组
    NSMutableArray *imageArray = [[NSMutableArray alloc]init];
    for (int i = 0; i < 4; i ++) {
        
        UIImage *image = [UIImage imageNamed:[NSString stringWithFormat:@"%d",i]];
        
        [imageArray addObject:image];
    }
    
    //初始化
    self.backgroundParallaxView = [[XSBackgroundParallaxView alloc]initWithFrame:self.view.frame];
    //设置背景图片
    [self.backgroundParallaxView setImageBackground:[UIImage imageNamed:@"backgroundImage"]];
    //设置前景图片
    [self.backgroundParallaxView setContentImages:imageArray];
    
    [self.view addSubview:self.backgroundParallaxView];
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

@end
