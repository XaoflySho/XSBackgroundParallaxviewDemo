//
//  XSBackgroundParallaxView.h
//  Kuke
//
//  Created by Xaofly Sho on 2016.
//  Copyright © 2016年 Xaofly Sho. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface XSBackgroundParallaxView : UIView

/*
 前景的ScrollView，便于外部添加前景控件。
 提供 
 - (void)setContentImages:(NSArray *)images 
 方法，快速设置一组前景图片
 */
@property (nonatomic, strong) UIScrollView *contentScrollView;

/*
 与前景ScrollView绑定，显示页数
 */
@property (nonatomic, strong) UIPageControl *contentPageControl;

/*
 设置背景图片
 */
- (void)setImageBackground:(UIImage *)image;

/*
 设置前景图片
 */
- (void)setContentImages:(NSArray *)images;

@end
