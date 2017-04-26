//
//  ViewController.m
//  Calculator
//
//  Created by Александр Светлый on 12.03.17.
//  Copyright © 2017 Александр Светлый. All rights reserved.
//

#import "ViewController.h"

@interface ViewController ()

@property (strong, nonatomic) IBOutlet UILabel *resultText;

@property (nonatomic) NSNumber* tmpFirstValue;
@property (nonatomic) NSNumber* tmpLastValue;
@property (nonatomic) NSNumber* tmpResultValue;

@property (nonatomic) NSString* operation;
@property (nonatomic) NSNumberFormatter* formater;
@property (nonatomic) BOOL needClean;

@end

@implementation ViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    //init numbers
    self.tmpFirstValue = [[NSNumber alloc] initWithDouble:0];
    self.tmpLastValue = [[NSNumber alloc] initWithDouble:0];
    self.tmpResultValue = [[NSNumber alloc] initWithDouble:0];
    //init other prop
    self.operation = @"";
    self.needClean = YES;
    self.formater = [[NSNumberFormatter alloc] init];
    self.formater.numberStyle = NSNumberFormatterDecimalStyle;
    [self.formater setPositiveFormat:@"0.##############"];
}


- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

- (void)cleanResultFieldIfNeeded {
    if (self.needClean) {
        [self.resultText setText:@""];
        self.needClean = NO;
    }
}

- (void)doneOperationWithString:(NSString*)string {
    [self.resultText setText:string];
    self.needClean = YES;
    self.operation = @"";
    self.tmpFirstValue = [NSNumber numberWithDouble:0];
    self.tmpLastValue = [NSNumber numberWithDouble:0];
    self.tmpResultValue = [NSNumber numberWithDouble:0];
}

- (IBAction)acButtonWasPressed:(UIButton *)sender {
    [self doneOperationWithString:@"0"];
}

- (IBAction)signedButtonWasPressed:(UIButton *)sender {
    [self.resultText setText:[self.formater stringFromNumber:[NSNumber numberWithDouble:(-1 * [self.resultText.text doubleValue])]]];
}

- (IBAction)dotButtonWasPressed:(UIButton *)sender {
    [self cleanResultFieldIfNeeded];
    if ([self.resultText.text length] == 0) [self.resultText setText:@"0"];
    if (![self.resultText.text containsString:sender.titleLabel.text]) {
        [self.resultText setText:[self.resultText.text stringByAppendingString:sender.titleLabel.text]];
    }
}

- (IBAction)operationButtonWasPressed:(UIButton *)sender {
    self.tmpFirstValue = [self.formater numberFromString:self.resultText.text];
    self.operation = sender.titleLabel.text;
    self.needClean = YES;
}

- (IBAction)resultButtonWasPressed:(UIButton *)sender {
    if ([self.operation length] > 0) {
        self.tmpLastValue = [self.formater numberFromString:self.resultText.text];
        if ([self.operation isEqualToString:opPlus]) {
            self.tmpResultValue = [NSNumber numberWithDouble:([self.tmpFirstValue doubleValue] + [self.tmpLastValue doubleValue])];
        }
        if ([self.operation isEqualToString:opMinus]) {
            self.tmpResultValue = [NSNumber numberWithDouble:([self.tmpFirstValue doubleValue] - [self.tmpLastValue doubleValue])];
        }
        if ([self.operation isEqualToString:opMult]) {
            self.tmpResultValue = [NSNumber numberWithDouble:([self.tmpFirstValue doubleValue] * [self.tmpLastValue doubleValue])];
        }
        if ([self.operation isEqualToString:opDivi]) {
            if ([self.tmpLastValue doubleValue] == 0.0) {
                [self doneOperationWithString:@"Error"];
                return;
            }
            self.tmpResultValue = [NSNumber numberWithDouble:([self.tmpFirstValue doubleValue] / [self.tmpLastValue doubleValue])];
        }
        [self doneOperationWithString:[self.formater stringFromNumber:self.tmpResultValue]];
    }
}

- (IBAction)numberPressed:(UIButton *)sender {
    [self cleanResultFieldIfNeeded];
    if([self.resultText.text isEqualToString:@"0"] && sender.tag == 0) {
        self.needClean = YES;
        return;
    }
    [self.resultText setText:[self.resultText.text stringByAppendingString:[NSString stringWithFormat:@"%li",sender.tag]]];
}
@end
