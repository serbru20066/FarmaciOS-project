//
//  LoguinViewController.h
//  proyectoFarmaciOS
//
//  Created by bruno on 14/05/14.
//  Copyright (c) 2014 Bruno Cardenas. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "UITextField_Extension.h"

@interface LoguinViewController : UIViewController
@property (weak, nonatomic) IBOutlet UIButton *btnIngresar;

@property (weak, nonatomic) IBOutlet UITextField_Extension *txtUsuario;
@property (weak, nonatomic) IBOutlet UITextField_Extension *txtContrasena;
- (IBAction)actionBtnIngresar:(id)sender;
@end
