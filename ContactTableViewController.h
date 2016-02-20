//
//  ContactTableViewController.h
//  BexApp
//
//  Created by Timotheus Jochum on 20/02/16.
//  Copyright © 2016 Timotheus Jochum. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface ContactTableViewController : UITableViewController
@property (weak, nonatomic) IBOutlet UIBarButtonItem *sidebarButton;
@property (strong, nonatomic) NSArray *menuItems;
@end
