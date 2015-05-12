//
//  ViewController.h
//  PayPalDemo
//
//  Created by Hack on 15-5-11.
//  Copyright (c) 2015年 SunHaoRan. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "PayPalMobile.h"
@interface ViewController : UIViewController<PayPalPaymentDelegate>

@property(nonatomic, strong, readwrite) NSString *environment;
@property(nonatomic, assign, readwrite) BOOL acceptCreditCards;
@property(nonatomic, strong, readwrite) NSString *resultText;
@end

