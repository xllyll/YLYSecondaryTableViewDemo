//
//  ViewController.m
//  YLYSecondaryTableViewDemo
//
//  Created by 杨卢银 on 15/6/27.
//  Copyright (c) 2015年 杨卢银. All rights reserved.
//

#import "ViewController.h"
#import "YLYSTableView.h"

@interface ViewController ()<YLYSTableViewDatasource>
{
    NSArray *_data;
}
@property (weak, nonatomic) IBOutlet YLYSTableView *tableView;
@end

@implementation ViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view, typically from a nib.
    _data = @[@{@"title":@"张",@"list":@[@"zhang1",@"zhang2",@"zhang3"]},
                      @{@"title":@"李",@"list":@[@"zhang1",@"zhang2",@"zhang3"]},
                      @{@"title":@"王",@"list":@[@"zhang1",@"zhang2",@"zhang3"]},
                      @{@"title":@"家人",@"list":@[@"zhang1",@"zhang2",@"zhang3"]},
                      @{@"title":@"朋友",@"list":@[@"zhang1",@"zhang2",@"zhang3"]},
                      @{@"title":@"老师",@"list":@[@"zhang1",@"zhang2",@"zhang3"]},
                      @{@"title":@"损友",@"list":@[@"zhang1",@"zhang2",@"zhang3"]},];
    _tableView.data = _data;
    _tableView.sDataSource= self;
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}
#pragma mark tableView datasource
-(NSInteger)numberOfSectionsInYLYSTableView:(YLYSTableView *)tableView{
    return _data.count;
}
-(NSInteger)ylystableView:(YLYSTableView *)stableView numberOfRowsInSection:(NSInteger)section{
    
    return 0;
}
-(UITableViewCell *)ylystableView:(YLYSTableView *)stableView cellForRowAtIndexPath:(NSIndexPath *)indexPath{
    static NSString *CELLID = @"Cell";
    UITableViewCell *cell = [stableView dequeueReusableCellWithIdentifier:CELLID forIndexPath:indexPath];
    cell.textLabel.text = _data[indexPath.section][@"list"][indexPath.row];
    return cell;
}
-(NSString *)ylystableView:(YLYSTableView *)tableView titleForHeaderInSection:(NSInteger)section{
    return _data[section][@"title"];
}
@end
