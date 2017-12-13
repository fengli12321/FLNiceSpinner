//
//  FLViewController.m
//  FLNiceSpinner
//
//  Created by fengli12321@163.com on 12/13/2017.
//  Copyright (c) 2017 fengli12321@163.com. All rights reserved.
//

#import "FLViewController.h"
#import "FLNiceSpinner.h"

@interface FLViewController () <FLNiceSpinnerDelegate>
@property (weak, nonatomic) IBOutlet FLNiceSpinner *spinner1;
@property (weak, nonatomic) IBOutlet FLNiceSpinner *spinner2;
@property (weak, nonatomic) IBOutlet FLNiceSpinner *spinner3;
@property (weak, nonatomic) IBOutlet FLNiceSpinner *spinner4;
@property (weak, nonatomic) IBOutlet FLNiceSpinner *spinner5;
@property (weak, nonatomic) IBOutlet FLNiceSpinner *spinner6;
@property (weak, nonatomic) IBOutlet FLNiceSpinner *spinner7;
@property (weak, nonatomic) IBOutlet FLNiceSpinner *spinner8;
@property (weak, nonatomic) IBOutlet FLNiceSpinner *spinner9;
@property (nonatomic, strong) NSArray *arr1;
@property (nonatomic, strong) NSArray *arr2;
@property (nonatomic, strong) NSArray *arr3;
@property (nonatomic, strong) NSArray *arr4;
@property (nonatomic, strong) NSArray *arr5;
@property (nonatomic, strong) NSArray *arr6;
@property (nonatomic, strong) NSArray *arr7;
@property (nonatomic, strong) NSArray *arr8;
@property (nonatomic, strong) NSArray *arr9;

@end

@implementation FLViewController

- (void)viewDidLoad
{
    [super viewDidLoad];
    _spinner1.delegate = self;
    _spinner1.textColor = [UIColor yellowColor];
    _spinner1.spaceString = @"请选择姓名";
    _spinner1.backColor = [UIColor blueColor];
    _spinner1.selectedBackColor = [UIColor orangeColor];
    _spinner2.delegate = self;
    _spinner2.isAsyncGetData = YES;
    _spinner2.font = [UIFont systemFontOfSize:20];
    _spinner1.listItemFont = [UIFont systemFontOfSize:12];
    _spinner3.delegate = self;
    _spinner4.delegate = self;
    _spinner5.delegate = self;
    _spinner6.delegate = self;
    _spinner7.delegate = self;
    _spinner8.delegate = self;
    _spinner9.delegate = self;
    
    _arr1 = @[@"小明", @"西方", @"东方不败", @"西方失败"];
    _arr2 = @[@"男", @"女"];
    
    _arr3 = @[@"一班", @"二班", @"三班"];
    
    NSMutableArray *arr = [NSMutableArray array];
    for (int i = 1; i < 10; i ++) {
        [arr addObject:[NSString stringWithFormat:@"第%d组", i]];
    }
    _arr4 = [arr copy];
    
    _arr5 = @[@"中文", @"英文", @"法语", @"德语", @"西班牙语", @"四川话"];
    _arr6 = @[@"软件工程", @"通信技术", @"机械设计", @"搬砖"];
    arr = [@[] mutableCopy];
    for (int i = 0; i < 30; i ++) {
        [arr addObject:[NSString stringWithFormat:@"%dcm", 150 + i]];
    }
    _arr7 = [arr copy];
    arr = [@[] mutableCopy];
    for (int i = 0; i < 30; i ++) {
        [arr addObject:[NSString stringWithFormat:@"%dkg", 40 + i]];
    }
    _arr8 = [arr copy];
    
    arr = [@[] mutableCopy];
    for (int i = 0; i < 100; i ++) {
        [arr addObject:[NSString stringWithFormat:@"%d score", i]];
    }
    _arr9 = [arr copy];
}

- (NSString *)fl_spinner:(FLNiceSpinner *)spinner showItemStringAtIndex:(NSInteger)index {
    if ([spinner isEqual:_spinner1]) {
        return _arr1[index];
    }
    else if ([spinner isEqual:_spinner2]) {
        return _arr2[index];
    }
    else if ([spinner isEqual:_spinner3]) {
        return _arr3[index];
    }
    else if ([spinner isEqual:_spinner4]) {
        return _arr4[index];
    }
    else if ([spinner isEqual:_spinner5]) {
        return _arr5[index];
    }
    else if ([spinner isEqual:_spinner6]) {
        return _arr6[index];
    }
    else if ([spinner isEqual:_spinner7]) {
        return _arr7[index];
    }
    else if ([spinner isEqual:_spinner8]) {
        return _arr8[index];
    }
    else if ([spinner isEqual:_spinner9]) {
        return _arr9[index];
    }
    return nil;
}
- (NSInteger)fl_itemsCountOfSpinner:(FLNiceSpinner *)spinner {
    if ([spinner isEqual:_spinner1]) {
        
        return _arr1.count;
    }
    else if ([spinner isEqual:_spinner2]) {
        return _arr2.count;
    }
    else if ([spinner isEqual:_spinner3]) {
        return _arr3.count;
    }
    else if ([spinner isEqual:_spinner4]) {
        return _arr4.count;
    }
    else if ([spinner isEqual:_spinner5]) {
        return _arr5.count;
    }
    else if ([spinner isEqual:_spinner6]) {
        return _arr6.count;
    }
    else if ([spinner isEqual:_spinner7]) {
        return _arr7.count;
    }
    else if ([spinner isEqual:_spinner8]) {
        return _arr8.count;
    }
    else if ([spinner isEqual:_spinner9]) {
        return _arr9.count;
    }
    return 0;
}

- (void)fl_spinner:(FLNiceSpinner *)spinner requestDataSuccess:(void (^)(NSArray<NSString *> *))success fail:(void (^)(void))fail {
    dispatch_after(dispatch_time(DISPATCH_TIME_NOW, (int64_t)(1 * NSEC_PER_SEC)), dispatch_get_main_queue(), ^{
        success(_arr2);
    });
}

- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

@end
