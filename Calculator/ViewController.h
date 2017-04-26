//
//  ViewController.h
//  Calculator
//
//  Created by Александр Светлый on 12.03.17.
//  Copyright © 2017 Александр Светлый. All rights reserved.
//

#import <UIKit/UIKit.h>

static NSString * const opPlus = @"+";
static NSString * const opMinus = @"−";
static NSString * const opMult = @"×";
static NSString * const opDivi = @"÷";

@interface ViewController : UIViewController

- (void)viewDidLoad;
- (void)didReceiveMemoryWarning;
- (void)cleanResultFieldIfNeeded;
- (void)doneOperationWithString:(NSString*)string;

- (IBAction)acButtonWasPressed:(UIButton *)sender;
- (IBAction)signedButtonWasPressed:(UIButton *)sender;
- (IBAction)dotButtonWasPressed:(UIButton *)sender;
- (IBAction)operationButtonWasPressed:(UIButton *)sender;
- (IBAction)resultButtonWasPressed:(UIButton *)sender;
- (IBAction)numberPressed:(UIButton *)sender;

@end

