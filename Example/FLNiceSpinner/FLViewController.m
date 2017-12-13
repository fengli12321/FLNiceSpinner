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

@end

@implementation FLViewController

- (void)viewDidLoad
{
    [super viewDidLoad];
	// Do any additional setup after loading the view, typically from a nib.
    
    FLNiceSpinner *spinner = [[FLNiceSpinner alloc] initWithFrame:CGRectMake(100, 100, 200, 40)];
    spinner.delegate = self;
    spinner.textColor = [UIColor blueColor];
    [self.view addSubview:spinner];
    
}

- (NSString *)fl_spinner:(FLNiceSpinner *)spinner showItemStringAtIndex:(NSInteger)index {
    return [NSString stringWithFormat:@"%ld", index];
}
- (NSInteger)fl_itemsCountOfSpinner:(FLNiceSpinner *)spinner {
    return 11;
}

- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

@end
