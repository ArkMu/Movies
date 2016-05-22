//
//  CollectTableVC.m
//  Movies
//
//  Created by qingyun on 16/5/21.
//  Copyright © 2016年 qingyun. All rights reserved.
//

#import "CollectTableVC.h"

#import <AVOSCloud/AVOSCloud.h>
#import "Account.h"

#import "AppDelegate.h"

#import "HotMovieModel.h"
#import "HotMovieCell.h"

#import "DetailVC.h"

@interface CollectTableVC ()

@property (nonatomic, strong) NSMutableArray *collectArr;

@property (nonatomic, strong) AppDelegate *app;

@end

@implementation CollectTableVC

static NSString *cellIdentifier = @"Cell";

- (void)viewWillAppear:(BOOL)animated {
    AppDelegate *app = [UIApplication sharedApplication].delegate;
    _app = app;
    if (app.collectArr.count == 0) {
        _collectArr = app.collectArr;
    } else {
        _collectArr = [NSMutableArray array];
        [app.collectArr enumerateObjectsUsingBlock:^(id  _Nonnull obj, NSUInteger idx, BOOL * _Nonnull stop) {
            HotMovieModel *model = [HotMovieModel modelWithDictionary:(NSDictionary *)obj];
            [_collectArr addObject:model];
        }];
    }
    
    [self.tableView reloadData];
}

- (void)viewDidLoad {
    [super viewDidLoad];
    
    self.navigationItem.leftBarButtonItem = [[UIBarButtonItem alloc] initWithImage:[UIImage imageNamed:@"browser_previous@2x"] style:UIBarButtonItemStylePlain target:self action:@selector(goBack)];
    
    self.navigationItem.title = @"收藏";
    self.navigationController.navigationBar.tintColor = [UIColor whiteColor];
    
    [self.tableView registerNib:[UINib nibWithNibName:NSStringFromClass([HotMovieCell class]) bundle:nil] forCellReuseIdentifier:cellIdentifier];
    self.tableView.rowHeight = 120.f;
    
    _collectArr = [NSMutableArray array];
    
}

- (void)goBack {
    [self.navigationController popViewControllerAnimated:YES];
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

#pragma mark - Table view data source

- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView {
    return 1;
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section {
    return _collectArr.count;
}


- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath {
    HotMovieCell *cell = [tableView dequeueReusableCellWithIdentifier:cellIdentifier];
    
    cell.model = _collectArr[indexPath.row];
    
    return cell;
}

-(void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath {
    HotMovieModel *model = _collectArr[indexPath.row];
    
    DetailVC *detail = [self.storyboard instantiateViewControllerWithIdentifier:NSStringFromClass([DetailVC class])];
    detail.Id = model.Id;
    [self.navigationController pushViewController:detail animated:NO];
}


// Override to support conditional editing of the table view.
- (BOOL)tableView:(UITableView *)tableView canEditRowAtIndexPath:(NSIndexPath *)indexPath {
    // Return NO if you do not want the specified item to be editable.
    return YES;
}



// Override to support editing the table view.
- (void)tableView:(UITableView *)tableView commitEditingStyle:(UITableViewCellEditingStyle)editingStyle forRowAtIndexPath:(NSIndexPath *)indexPath {
    if (editingStyle == UITableViewCellEditingStyleDelete) {
       
        HotMovieModel *model = _collectArr[indexPath.row];
        NSMutableArray *marr = _app.collectArr;
        [_app.collectArr enumerateObjectsUsingBlock:^(id  _Nonnull obj, NSUInteger idx, BOOL * _Nonnull stop) {
            if ([[obj valueForKey:@"Id"] integerValue] == model.Id) {
                [marr removeObject:obj];
                *stop = YES;
            }
        }];
        _app.collectArr = marr;
        [_app.collectArr writeToFile:[_app createCollectPlist] atomically:YES];
        
        [_collectArr removeObjectAtIndex:indexPath.row];
        [tableView deleteRowsAtIndexPaths:@[indexPath] withRowAnimation:UITableViewRowAnimationFade];
    } else if (editingStyle == UITableViewCellEditingStyleInsert) {
        
    }   
}


/*
// Override to support rearranging the table view.
- (void)tableView:(UITableView *)tableView moveRowAtIndexPath:(NSIndexPath *)fromIndexPath toIndexPath:(NSIndexPath *)toIndexPath {
}
*/

/*
// Override to support conditional rearranging of the table view.
- (BOOL)tableView:(UITableView *)tableView canMoveRowAtIndexPath:(NSIndexPath *)indexPath {
    // Return NO if you do not want the item to be re-orderable.
    return YES;
}
*/

/*
#pragma mark - Navigation

// In a storyboard-based application, you will often want to do a little preparation before navigation
- (void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender {
    // Get the new view controller using [segue destinationViewController].
    // Pass the selected object to the new view controller.
}
*/

@end
