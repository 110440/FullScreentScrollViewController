//
//  FullScreentScrollViewController.m
//  tableViewTest
//
//  Created by tanson on 2017/1/11.
//  Copyright © 2017年 chatchat. All rights reserved.
//

#import "FullScreentScrollViewController.h"

////视差速率
#define _rate 0.6

@interface FullScreentScrollViewController ()<UIScrollViewDelegate>
@end

@implementation FullScreentScrollViewController{
    CGFloat _startY;
}

- (void)viewDidLoad {
    [super viewDidLoad];
}

- (void)viewWillAppear:(BOOL)animated{
    [super viewWillAppear:animated];
    self.tabBarController.tabBar.translucent = NO;
    self.navigationController.navigationBar.translucent = NO;
    self.edgesForExtendedLayout = UIRectEdgeAll;
    self.extendedLayoutIncludesOpaqueBars = YES;
    self.scrollView.delegate = self;
}

- (void)viewWillDisappear:(BOOL)animated {
    [super viewWillDisappear:animated];
    //[self hideBar:NO animated:NO];
    [self setNavBarOffset:-1000];
    [self setTabBarOffset:-1000];
}

-(void)viewWillLayoutSubviews{
    [super viewWillLayoutSubviews];
    if(self.tabBarController){
        UIEdgeInsets inset = self.scrollView.contentInset;
        inset.bottom = 0;
        self.scrollView.contentInset = inset;
    }
}

-(UIScrollView *)scrollView{
    NSAssert(NO, @"子类必需实现，返回指定的scrollView 或子类");
    return nil;
}

#pragma mark - scrollView  delegate

-(void)scrollViewWillBeginDragging:(UIScrollView *)scrollView{
    _startY = scrollView.contentOffset.y + scrollView.contentInset.top;
}

- (void)scrollViewDidEndDragging:(UIScrollView *)scrollView willDecelerate:(BOOL)decelerate {
    CGFloat maxy = CGRectGetMaxY(self.navigationController.navigationBar.frame);
    if(maxy <= 0) return;
    if(maxy <= 30){
        [self hideBar:YES animated:YES];
    }else{
        [self hideBar:NO animated:YES];
    }
}

-(void)scrollViewDidScroll:(UIScrollView *)scrollView{
    //在push到其他页面时候，show动画，和pop回来时，会触发该方法，这个时候不应该继续执行
    if (!(self.isViewLoaded && self.view.window != nil)) { return ; }

    if(scrollView.contentSize.height <= scrollView.bounds.size.height)return;
    
    CGFloat y = scrollView.contentOffset.y + scrollView.contentInset.top;
    if(y==0)return;
    
    CGFloat offset = y - _startY;
    offset = offset * _rate;
    
    [self setNavBarOffset:offset];
    [self setTabBarOffset:offset];
    NSLog(@"Y:%f",y);
    _startY  = MAX(y, 0);
    CGFloat inset = scrollView.contentInset.top + scrollView.contentInset.bottom;
    CGFloat maxOffsetY = scrollView.contentSize.height + inset - scrollView.bounds.size.height;
    _startY  = MIN(_startY, maxOffsetY);
    NSLog(@"starY:%f",_startY);
    [self updateInsets];
}

#pragma mark- private

-(void)setNavBarOffset:(CGFloat)offset{
    CGRect frame = self.navigationController.navigationBar.frame;
    frame.origin.y -= offset;
    frame.origin.y = MAX(frame.origin.y, -frame.size.height);
    frame.origin.y = MIN(frame.origin.y, 20); //20 状态栏高度
    self.navigationController.navigationBar.frame = frame;
}

-(void)setTabBarOffset:(CGFloat)offset{
    if(!self.tabBarController.tabBar)return;
    CGSize screentSize = [UIScreen mainScreen].bounds.size;
    CGRect frame = self.tabBarController.tabBar.frame;
    frame.origin.y += offset;
    frame.origin.y = MIN(screentSize.height,frame.origin.y);
    frame.origin.y = MAX(frame.origin.y,screentSize.height - frame.size.height);
    self.tabBarController.tabBar.frame = frame;
}

-(void)updateInsets{
    UIEdgeInsets inset = self.scrollView.contentInset;
    CGFloat top = CGRectGetMaxY(self.navigationController.navigationBar.frame);
    inset.top = top;
    if(self.tabBarController){
        CGFloat tabBarMinY = CGRectGetMinY(self.tabBarController.tabBar.frame);
        inset.bottom = MAX(0,[UIScreen mainScreen].bounds.size.height - tabBarMinY);
    }
    self.scrollView.scrollIndicatorInsets = inset;
}

- (void)hideBar:(BOOL)b animated:(BOOL)animated{
    
    CGFloat maxy = CGRectGetMaxY(self.navigationController.navigationBar.frame);
    if(b){ //hide
        maxy = maxy / _rate;
        CGPoint offset = self.scrollView.contentOffset;
        offset.y += maxy;
        [self.scrollView setContentOffset:offset animated:YES];
    }else{ //show
        CGPoint offset = self.scrollView.contentOffset;
        CGFloat lefty = 64 - maxy;
        lefty = lefty / _rate;
        offset.y -= lefty;
        [self.scrollView setContentOffset:offset animated:animated];
    }
}
-(void)testst{
    
}
@end
