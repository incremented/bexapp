//
//  ContactTableViewController.h
//  BexApp
//
//  Created by Timotheus Jochum on 20/02/16.
//  Copyright © 2016 Timotheus Jochum. All rights reserved.
//

#import <UIKit/UIKit.h>
#import <MessageUI/MessageUI.h>

@protocol KontaktTableViewControllerDelegate;

@interface KontaktTableViewController : UITableViewController <UITableViewDataSource, UITableViewDelegate, MFMailComposeViewControllerDelegate>
@property (weak, nonatomic) IBOutlet UIBarButtonItem *sidebarButton;
@property (strong, nonatomic) NSArray *menuItems;

@property (nonatomic, weak) NSObject<KontaktTableViewControllerDelegate>* delegate;

@end

@protocol KontaktTableViewControllerDelegate

- (void)kontaktTableViewControllerCalledMaps:(KontaktTableViewController *) viewController;

@end