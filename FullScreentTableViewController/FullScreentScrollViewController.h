//
//  FullScreentScrollViewController.h
//  tableViewTest
//
//  Created by tanson on 2017/1/11.
//  Copyright © 2017年 chatchat. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface FullScreentScrollViewController : UIViewController

@property (nonatomic,strong) UIScrollView * scrollView;

//子类的实现以下几个 scrollerView delegate 方法时 ， 要调用父类实现 ；
-(void)scrollViewWillBeginDragging:(UIScrollView *)scrollView NS_REQUIRES_SUPER;
-(void)scrollViewDidEndDragging:(UIScrollView *)scrollView willDecelerate:(BOOL)decelerate NS_REQUIRES_SUPER;
-(void)scrollViewDidScroll:(UIScrollView *)scrollView NS_REQUIRES_SUPER;

@end
