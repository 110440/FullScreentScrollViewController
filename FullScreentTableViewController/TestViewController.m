//
//  TestViewController.m
//  FullScreentScrollViewController
//
//  Created by tanson on 2017/1/11.
//  Copyright © 2017年 chatchat. All rights reserved.
//

#import "TestViewController.h"
#import "ViewController2.h"

@interface TestViewController ()<UITableViewDataSource,UITableViewDelegate>

@property (nonatomic ,strong)UITableView * tableView;
@end

@implementation TestViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    [self.view addSubview:self.tableView];
}

-(UITableView *)tableView{
    if(!_tableView){
        _tableView = [[UITableView alloc] initWithFrame:self.view.bounds];
        _tableView.dataSource = self;
        _tableView.delegate = self;
    }
    return _tableView;
}

-(UIScrollView *)scrollView{
    return self.tableView;
}

-(void)viewDidLayoutSubviews{
    [super viewDidLayoutSubviews];
    CGRect frame = self.view.bounds;
    self.tableView.frame = frame;
}

-(NSInteger)numberOfSectionsInTableView:(UITableView *)tableView{
    return 1;
}

-(NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section{
    return 40;
}

-(UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath{
    UITableViewCell * cell = [[UITableViewCell alloc] initWithStyle:UITableViewCellStyleDefault reuseIdentifier:nil];
    cell.textLabel.text = [NSString stringWithFormat:@"cell%ld",(long)indexPath.row];
    return cell;
}

-(void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath{

    UIViewController * vc = [[ViewController2 alloc] init];
    vc.hidesBottomBarWhenPushed = YES;
    vc.edgesForExtendedLayout = UIRectEdgeNone;
    [self.navigationController pushViewController:vc animated:YES];
}

-(CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath{
    return 44;
}

@end
