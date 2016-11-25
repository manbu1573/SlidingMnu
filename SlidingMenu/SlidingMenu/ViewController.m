//
//  ViewController.m
//  SlidingMenu
//
//  Created by 李荣建 on 2016/11/25.
//  Copyright © 2016年 李荣建. All rights reserved.
//

#import "ViewController.h"
#import "SegmentTapView.h"
#import "FlipTableView.h"
#import "Persion.h"
#import "CompanyViewController.h"
#import "ElectronicViewController.h"
#define kSCREEN_WIDTH [UIScreen mainScreen].bounds.size.width
#define kSCREEN_HEIGHT [UIScreen mainScreen].bounds.size.height

@interface ViewController ()<SegmentTapViewDelegate,FlipTableViewDelegate>
@property (nonatomic, strong)SegmentTapView *segment;
@property (nonatomic, strong)FlipTableView *flipView;
@property (nonatomic, strong)NSMutableArray *controllsArray;

@end

@implementation ViewController
-(NSMutableArray *)controllsArray
{
    if (_controllsArray == nil) {
        _controllsArray = [[NSMutableArray alloc] init];
    }
    return _controllsArray;
}

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view, typically from a nib.
    //设置segment
    self.segment = [[SegmentTapView alloc] initWithFrame:CGRectMake(0, 100, kSCREEN_WIDTH, 40) withDataArray:[NSArray arrayWithObjects:@"个人业务",@"企业业务",@"电子业务", nil] withFont:14];
    self.segment.textNomalColor = [UIColor blackColor];
    self.segment.textSelectedColor = [UIColor blueColor];
    self.segment.lineColor = [UIColor blueColor];
    self.segment.delegate = self;
    [self.view addSubview:self.segment];

    Persion *personalController = [Persion new];
    CompanyViewController *companyViewController = [CompanyViewController new];
    ElectronicViewController *electronicViewController = [ElectronicViewController new];
    [self.controllsArray addObject:personalController];
    [self.controllsArray addObject:companyViewController];
    [self.controllsArray addObject:electronicViewController];
//    [self addChildViewController:personalController];
//    [self addChildViewController:companyViewController];
//    [self addChildViewController:electronicViewController];
    
    self.flipView = [[FlipTableView alloc] initWithFrame:CGRectMake(0, 150, kSCREEN_WIDTH, 200) withArray:_controllsArray];
    self.flipView.delegate = self;
    [self.view addSubview:self.flipView];

}

#pragma mark -------- select Index
/**
 选择回调
 
 @param index 对应的下标（从0开始）
 */
-(void)selectedIndex:(NSInteger)index
{
    [self.flipView selectIndex:index];

}
/**
 滑动回调
 
 @param index 对应的下标（从1开始）
 */
-(void)scrollChangeToIndex:(NSInteger)index
{
    [self.segment selectIndex:index];

    
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

@end
