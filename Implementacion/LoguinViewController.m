//
//  LoguinViewController.m
//  proyectoFarmaciOS
//
//  Created by bruno on 14/05/14.
//  Copyright (c) 2014 Bruno Cardenas. All rights reserved.
//

#import "LoguinViewController.h"

@interface LoguinViewController ()

@end

@implementation LoguinViewController

- (id)initWithNibName:(NSString *)nibNameOrNil bundle:(NSBundle *)nibBundleOrNil
{
    self = [super initWithNibName:nibNameOrNil bundle:nibBundleOrNil];
    if (self) {
        // Custom initialization
    }
    return self;
}

- (void)viewDidLoad
{
    [super viewDidLoad];
    //Cabecera
    [self.navigationController.navigationBar setBackgroundImage:[UIImage new]
                             forBarMetrics:UIBarMetricsDefault];
    self.navigationController.navigationBar.shadowImage = [UIImage new];
    self.navigationController.navigationBar.translucent = YES;
    
    //tap recognizer
    _tapGesture = [[UITapGestureRecognizer alloc] initWithTarget:self action:@selector(hideKeyboard)];
    _tapGesture.enabled = NO;
    [self.view addGestureRecognizer:_tapGesture];
}

- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

- (IBAction)actionBtnIngresar:(id)sender {
}

#pragma mark  TextField Delegates
- (BOOL)textFieldShouldReturn:(UITextField *)textField {
    
    [textField resignFirstResponder];
    return YES;
}
-(BOOL)textFieldShouldBeginEditing:(UITextField *)textField
{
    _tapGesture.enabled = YES;
    return YES;
}
#pragma mark  Utiles
-(void)hideKeyboard
{
    [_txtUsuario  resignFirstResponder];
    [_txtContrasena resignFirstResponder];

    
    _tapGesture.enabled = NO;
}

@end
