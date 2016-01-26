//
//  XSBackgroundParallaxView.m
//  Kuke
//
//  Created by Xaofly Sho on 2016.
//  Copyright © 2016年 Xaofly Sho. All rights reserved.
//

#import "XSBackgroundParallaxView.h"

@interface XSBackgroundParallaxView () <UIScrollViewDelegate>

@property (nonatomic, strong) UIScrollView *imageScrollView;

@end

#define SELF_Width self.frame.size.width
#define SELF_Height self.frame.size.height

@implementation XSBackgroundParallaxView

- (instancetype)initWithCoder:(NSCoder *)coder {
    
    self = [super initWithCoder:coder];
    if (self) {
        
        [self baseInit];
        
    }
    return self;
}

- (instancetype)initWithFrame:(CGRect)frame {
    
    self = [super initWithFrame:frame];
    if (self) {
        
        [self baseInit];
        
    }
    return self;
}

- (void)baseInit {
    
    self.imageScrollView = [[UIScrollView alloc] initWithFrame:self.bounds];
    self.imageScrollView.bounces = NO;
    self.imageScrollView.userInteractionEnabled = NO;
    self.imageScrollView.backgroundColor = [UIColor blackColor];
    
    [self addSubview:self.imageScrollView];
    
    self.contentScrollView = [[UIScrollView alloc] initWithFrame:self.bounds];
    self.contentScrollView.userInteractionEnabled = YES;
    self.contentScrollView.pagingEnabled = YES;
    self.contentScrollView.showsHorizontalScrollIndicator = NO;
    self.contentScrollView.delegate = self;
    
    [self addSubview:self.contentScrollView];
    
    self.contentPageControl = [[UIPageControl alloc]initWithFrame:CGRectMake(0, SELF_Height - 30, SELF_Width, 30)];
    self.contentPageControl.currentPage = 0;
    [self.contentPageControl addTarget:self action:@selector(pageControlValueChange:) forControlEvents:UIControlEventValueChanged];
    [self addSubview:self.contentPageControl];

}//初始化ScrollView、PageControl

- (void)setImageBackground:(UIImage *)image {
    
    UIImageView *backgroundImageView = [[UIImageView alloc] initWithImage:image];
    
    CGFloat bgHeight = CGRectGetHeight(self.bounds);
    CGFloat bgWidth = (image.size.width * bgHeight) / image.size.height;
    
    backgroundImageView.frame = CGRectMake(0, 0, bgWidth, bgHeight);
    
    [self.imageScrollView setContentSize:CGSizeMake(CGRectGetWidth(backgroundImageView.frame), CGRectGetHeight(backgroundImageView.frame))];
    [self.imageScrollView addSubview:backgroundImageView];
    
}//设置背景图片

- (void)setContentImages:(NSArray *)images {
    
    NSInteger imageNumber = images.count;
    if (imageNumber == 1) {
        self.contentPageControl.hidden = YES;
    }
    self.contentPageControl.numberOfPages = imageNumber;
    self.contentScrollView.contentSize = CGSizeMake(SELF_Width * imageNumber, SELF_Height);
    for (NSInteger i = 0; i < imageNumber; i ++) {
        UIImageView *imageV = [[UIImageView alloc]initWithFrame:CGRectMake(i * SELF_Width, 0, SELF_Width, SELF_Height)];
        imageV.image = images[i];
        imageV.contentMode = UIViewContentModeCenter;
        [self.contentScrollView addSubview:imageV];
    }
    
}//设置前景图片

- (CGFloat)maximumOffsetForScrollView:(UIScrollView *)scrollView {
    
    CGFloat contentWidth = scrollView.contentSize.width;
    CGFloat frameWidth = CGRectGetWidth(scrollView.frame);
    
    return contentWidth - frameWidth;
}

- (void)scrollViewDidScroll:(UIScrollView *)scrollView {
    
    CGFloat currentOffset = self.contentScrollView.contentOffset.x;
    
    if (currentOffset >= 0 && currentOffset <= (self.contentScrollView.contentSize.width - CGRectGetWidth(self.bounds))) {
        CGFloat maximumContentOffset = [self maximumOffsetForScrollView:self.contentScrollView];
        
        CGFloat percentageOffset = currentOffset / maximumContentOffset;
        
        CGFloat maximumImageOffset = [self maximumOffsetForScrollView:self.imageScrollView];
        CGFloat actualImageOffset = maximumImageOffset * percentageOffset;
        
        [self.imageScrollView setContentOffset:CGPointMake(actualImageOffset, 0)];
    }
    
    NSInteger index = fabs(scrollView.contentOffset.x) / scrollView.frame.size.width;
    [self.contentPageControl setCurrentPage:index];
}

- (void)pageControlValueChange:(UIPageControl *)pageControl {
    
    [self.contentScrollView setContentOffset:CGPointMake(pageControl.currentPage * SELF_Width, 0) animated:YES];
}

@end

