//
//  LocalesVC.h
//  proyectoFarmaciOS
//
//  Created by TKJ on 5/28/14.
//  Copyright (c) 2014 Bruno Cardenas. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "OMBActivityView.h"


@interface LocalesVC : UIViewController<UITableViewDataSource,UITableViewDelegate>
{
OMBActivityView *activityView;
}
@property (weak, nonatomic) IBOutlet UITableView *tableView;

@end
