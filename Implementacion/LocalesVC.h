//
//  LocalesVC.h
//  proyectoFarmaciOS
//
//  Created by TKJ on 5/28/14.
//  Copyright (c) 2014 Bruno Cardenas. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface LocalesVC : UIViewController<UITableViewDataSource,UITableViewDelegate>
@property (weak, nonatomic) IBOutlet UITableView *tableView;

@end
