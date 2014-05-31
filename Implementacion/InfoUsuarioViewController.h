//
//  InfoUsuarioViewController.h
//  proyectoFarmaciOS
//
//  Created by bruno on 25/05/14.
//  Copyright (c) 2014 Bruno Cardenas. All rights reserved.
//

#import <UIKit/UIKit.h>
#import <FacebookSDK/FacebookSDK.h>

@interface InfoUsuarioViewController : UIViewController<FBLoginViewDelegate>
{
  NSUserDefaults *standardDefaults ;
}
@property FBProfilePictureView *profilePictureView;


@end
