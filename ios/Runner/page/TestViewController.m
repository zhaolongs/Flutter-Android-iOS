//
//  TestViewController.m
//  Runner
//
//  Created by  androidlongs on 2019/7/17.
//  Copyright © 2019 The Chromium Authors. All rights reserved.
//

#import "TestViewController.h"

@interface TestViewController ()

@end

@implementation TestViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view from its nib.
}
- (IBAction)backClickFunction:(id)sender {
    [self dismissViewControllerAnimated:YES completion:nil];
}
- (IBAction)toFlutterMessageClick:(id)sender {
    [[NSNotificationCenter defaultCenter] postNotificationName:@"ios.to.flutter" object:nil];
}

/*
#pragma mark - Navigation

// In a storyboard-based application, you will often want to do a little preparation before navigation
- (void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender {
    // Get the new view controller using [segue destinationViewController].
    // Pass the selected object to the new view controller.
}
*/

@end
