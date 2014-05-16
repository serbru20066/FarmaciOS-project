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
    
        [self.btnIngresar setFrame:CGRectMake(-253, 370, 226, 36)];
        [self.img3 setFrame:CGRectMake(351, 239, 228, 90)];
        [self.img1 setFrame:CGRectMake(360, 250, 20, 23)];
        [self.img2 setFrame:CGRectMake(353, 293, 34, 28)];
        [self.txtUsuario setFrame:CGRectMake(399, 250, 166, 30)];
        [self.txtContrasena setFrame:CGRectMake(399, 293, 166, 30)];
        self.logo.alpha = 0;
        self.logo1.alpha = 0;
    
    [UIView animateWithDuration:0.8 delay:0.5 options:UIViewAnimationOptionCurveLinear animations:^{
        
        

        [self.btnIngresar setFrame:CGRectMake(53, 370, 226, 36)];
        [self.img3 setFrame:CGRectMake(51, 239, 228, 90)];
        [self.img1 setFrame:CGRectMake(60, 250, 20, 23)];
        [self.img2 setFrame:CGRectMake(53, 293, 34, 28)];
        [self.txtUsuario setFrame:CGRectMake(99, 250, 166, 30)];
        [self.txtContrasena setFrame:CGRectMake(99, 293, 166, 30)];
        

    } completion:^(BOOL finished) {
        
        
        [UIView animateWithDuration:0.9 delay:0.0 options:UIViewAnimationOptionCurveLinear animations:^{
            
            
            self.logo.alpha = 1.0;
             self.logo1.alpha = 1.0;
            
            
        } completion:^(BOOL finished) {
            
        }];
        
    }];
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
