//
//  RegisterVC.m
//  Movies
//
//  Created by qingyun on 16/5/20.
//  Copyright © 2016年 qingyun. All rights reserved.
//

#import "RegisterVC.h"

#import "AppDelegate.h"

#import <AVOSCloud/AVOSCloud.h>

#import "Account.h"

#import "SVProgressHUD.h"

@interface RegisterVC ()

@property (weak, nonatomic) IBOutlet UITextField *nameTextField;

@property (weak, nonatomic) IBOutlet UITextField *passWordTextField;
@property (weak, nonatomic) IBOutlet UITextField *secureTextField;

@end

@implementation RegisterVC

- (void)viewDidLoad {
    [super viewDidLoad];

    self.navigationItem.leftBarButtonItem = [[UIBarButtonItem alloc] initWithImage:[UIImage imageNamed:@"browser_previous@2x"] style:UIBarButtonItemStylePlain target:self action:@selector(goBack)];
}

- (void)goBack {
    [self.navigationController popViewControllerAnimated:YES];
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}
- (IBAction)btnAction:(UIButton *)sender {
    if (_nameTextField.text != nil && _passWordTextField.text != nil) {
        NSLog(@"%@", _nameTextField.text);
        __weak typeof(self) weakSelf = self;
        
        
        AVUser *user = [[AVUser alloc] init];
        user.username = self.nameTextField.text;
        user.password = self.passWordTextField.text;
        [user signUpInBackgroundWithBlock:^(BOOL succeeded, NSError *error) {
            if (succeeded) {
                NSLog(@"注册成功%@",user.username);
                [[Account shareAccount] saveLogin:user.username];
                
                AppDelegate *app = [UIApplication sharedApplication].delegate;
                
                [app changeRootView];
            }else{
                [SVProgressHUD showErrorWithStatus:error.localizedDescription];
                _nameTextField.text = nil;
                _passWordTextField.text = nil;
                [_nameTextField becomeFirstResponder];
            }
        }];
        
        
        
//        [AVUser requestMobilePhoneVerify:_nameTextField.text withBlock:^(BOOL succeeded, NSError *error) {
//            if (succeeded) {
//                [AVUser verifyMobilePhone:_secureTextField.text withBlock:^(BOOL succeeded, NSError *error) {
//                    if (succeeded) {
//                        [SVProgressHUD showInfoWithStatus:@"注册成功"];
//                        
//                        [[Account shareAccount] saveLogin:_nameTextField.text];
//                        
//                        [weakSelf performSelector:@selector(gotoView) withObject:nil afterDelay:1.f];
//                        
//                    } else {
//                        [SVProgressHUD showErrorWithStatus:@"验证码错误"];
//                    }
//                }];
//            }
//        }];
    } else {
        [SVProgressHUD showInfoWithStatus:@"用户名、密码不能为空"];
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
