//
//  SidebarTableViewController.m
//  BexApp
//
//  Created by Timotheus Jochum on 18/02/16.
//  Copyright © 2016 Timotheus Jochum. All rights reserved.
//

#import "SidebarTableViewController.h"

@interface SidebarTableViewController ()

@end

@implementation SidebarTableViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    
    [self initialiseMenu];
}

- (void)initialiseMenu {
    _menuItems = @[@"tableHeader", @"tableWelcome", @"tableContact", @"tableMap"];
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
    return _menuItems.count;
}


- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath {
    NSString *CellIdentifier = [_menuItems objectAtIndex:indexPath.row];
    UITableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:CellIdentifier forIndexPath:indexPath];
 
 return cell;
}
@end
