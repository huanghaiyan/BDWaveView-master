//
//  ViewController.m
//  BDWaveView-master
//
//  Created by 黄海燕 on 16/9/6.
//  Copyright © 2016年 huanghy. All rights reserved.
//

#import "ViewController.h"
#import "BDWaveView.h"
@interface ViewController ()<UITableViewDelegate,UITableViewDataSource>

@property (nonatomic,strong) UITableView *mTableView;
@property (nonatomic,strong) UIView *headerView;

@end

@implementation ViewController

- (UIView *)headerView
{
    if (!_headerView) {
        _headerView = [[UIView alloc]initWithFrame:CGRectMake(0, 0, self.view.frame.size.width, 200)];
        _headerView.backgroundColor = [UIColor redColor];
        BDWaveView *waveView = [[BDWaveView alloc]initWithFrame:CGRectMake(0, 192, _headerView.frame.size.width, 8)];
        waveView.iconImageView.image = [UIImage imageNamed:@"1.jpg"];
        [_headerView addSubview:waveView];
    }
    return _headerView;
}

- (UITableView *)mTableView
{
    if (!_mTableView) {
        _mTableView = [[UITableView alloc]initWithFrame:self.view.frame style:UITableViewStylePlain];
        _mTableView.dataSource = self;
        _mTableView.delegate = self;
        _mTableView.separatorStyle = UITableViewCellSeparatorStyleNone;
        _mTableView.tableHeaderView = self.headerView;
    }
    return _mTableView;
}

- (void)viewDidLoad {
    [super viewDidLoad];
    
    [self.view addSubview:self.mTableView];
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section
{
    return 15;
}

-(UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
    static NSString *cellID = @"CELL";
    UITableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:cellID];
    if (!cell) {
        cell = [[UITableViewCell alloc]initWithStyle:UITableViewCellStyleDefault reuseIdentifier:cellID];
    }
    cell.textLabel.text = [NSString stringWithFormat:@"index -- %ld",indexPath.row];
    return cell;
}

@end
