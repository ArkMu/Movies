//
//  LoginVC.m
//  Movies
//
//  Created by qingyun on 16/5/20.
//  Copyright © 2016年 qingyun. All rights reserved.
//

#import "LoginVC.h"

#import <AVOSCloud/AVOSCloud.h>
#import "SVProgressHUD.h"

#import "Account.h"

#import "AppDelegate.h"

@interface LoginVC ()

@property (weak, nonatomic) IBOutlet UITextField *nameTextField;
@property (weak, nonatomic) IBOutlet UITextField *passWordTextField;

@property (weak, nonatomic) IBOutlet UIButton *btn;

@end

@implementation LoginVC

- (void)viewDidLoad {
    [super viewDidLoad];

}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

- (IBAction)btnAction:(UIButton *)sender {
    if (_nameTextField.text != nil && _passWordTextField.text != nil) {
        [AVUser logInWithUsernameInBackground:_nameTextField.text password:_passWordTextField.text block:^(AVUser *user, NSError *error) {
            if (user) {
                [[Account shareAccount] saveLogin:user.username];
                
                AppDelegate *app = [UIApplication sharedApplication].delegate;
                [app changeRootView];
                
                [_btn setTitle:@"退出" forState:UIControlStateNormal];
            } else {
                [SVProgressHUD showInfoWithStatus:@"用户名或密码错误， 请重新输入"];
                _nameTextField.text = nil;
                _passWordTextField.text = nil;
                [_nameTextField becomeFirstResponder];
            }
        }];
    }
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
