//
//  ChangeNameViewController.h
//  JK189Apple
//
//  Created by wang basil on 14-12-17.
//  Copyright (c) 2014年 yalin. All rights reserved.
//

#import <UIKit/UIKit.h>

@protocol ChangeNameViewControllerDelegate <NSObject>

@optional
-(void) changeName:(NSString *)name;

@end

@interface ChangeNameViewController : BaseViewController{
    UITextField *name;
    NSString *defaultName;
}

@property (nonatomic,assign) id<ChangeNameViewControllerDelegate> delegate;
-(void) setName:(NSString *)dName;
@end
