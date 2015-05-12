//
//  ViewController.m
//  PayPalDemo
//
//  Created by Hack on 15-5-11.
//  Copyright (c) 2015年 SunHaoRan. All rights reserved.
//

#import "ViewController.h"
#import <QuartzCore/QuartzCore.h>
#define kPayPalEnvironment @"sandbox"
@interface ViewController ()


@property(nonatomic,strong,readwrite) PayPalConfiguration *paypalConfig;
@end

@implementation ViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    
    _paypalConfig = [[PayPalConfiguration alloc]init];
    _paypalConfig.acceptCreditCards = NO;
    _paypalConfig.merchantName = @"";
    _paypalConfig.merchantPrivacyPolicyURL = [NSURL URLWithString:@""];
    _paypalConfig.merchantUserAgreementURL = [NSURL URLWithString:@""];
    
    
 
    
    _paypalConfig.payPalShippingAddressOption = PayPalShippingAddressOptionNone;
    
  
    self.environment = kPayPalEnvironment;
    
    NSLog(@"PayPal iOS SDK version: %@", [PayPalMobile libraryVersion]);

    // Do any additional setup after loading the view, typically from a nib.
}
-(void)viewWillAppear:(BOOL)animated
{
    [self setPayPalEnvironment:self.environment];
}

#pragma mark - Receive Single Payment

- (void)setPayPalEnvironment:(NSString *)environment {
    self.environment = environment;
    [PayPalMobile preconnectWithEnvironment:environment];
}
- (IBAction)Pay_Click:(id)sender {
    
    self.resultText = nil;
#pragma mark 此处定义IAP
//    PayPalItem *item1 = [PayPalItem itemWithName:@"风暴远征60钻石"
//                                    withQuantity:1
//                                       withPrice:[NSDecimalNumber decimalNumberWithString:@"5.99"]
//                                    withCurrency:@"USD"
//                                         withSku:@"Hip-00037"];
//    PayPalItem *item2 = [PayPalItem itemWithName:@"风暴远征120钻石"
//                                    withQuantity:1
//                                       withPrice:[NSDecimalNumber decimalNumberWithString:@"0.00"]
//                                    withCurrency:@"USD"
//                                         withSku:@"Hip-00066"];
//    PayPalItem *item3 = [PayPalItem itemWithName:@"风暴远征300钻石"
//                                    withQuantity:1
//                                       withPrice:[NSDecimalNumber decimalNumberWithString:@"37.99"]
//                                    withCurrency:@"USD"
//                                         withSku:@"Hip-00291"];
//    NSArray *items = @[item1];//所有购买的产品集合
    
//    NSDecimalNumber *subtotal = [PayPalItem totalPriceForItems:items];
    
    // Optional: include payment details
//    NSDecimalNumber *shipping = [[NSDecimalNumber alloc] initWithString:@"5.99"];
//    NSDecimalNumber *tax = [[NSDecimalNumber alloc] initWithString:@"2.50"];
//    PayPalPaymentDetails *paymentDetails = [PayPalPaymentDetails paymentDetailsWithSubtotal:subtotal
//                                                                               withShipping:shipping
//                                                                                    withTax:tax];
//    
//    NSDecimalNumber *total = [[subtotal decimalNumberByAdding:shipping] decimalNumberByAdding:tax];
    
   
    
    PayPalPayment *payment = [[PayPalPayment alloc] init];
    payment.amount = [[NSDecimalNumber alloc] initWithString:@"4.99"];;
    payment.currencyCode = @"USD";
    payment.shortDescription = @"风暴英雄60钻石";
    payment.items = nil;  // if not including multiple items, then leave payment.items as nil
    payment.paymentDetails = nil; // if not including payment details, then leave payment.paymentDetails as nil
    payment.intent = PayPalPaymentIntentSale;
    if (!payment.processable) {
        // This particular payment will always be processable. If, for
        // example, the amount was negative or the shortDescription was
        // empty, this payment wouldn't be processable, and you'd want
        // to handle that here.
    }
    
    // Update payPalConfig re accepting credit cards.
    self.paypalConfig.acceptCreditCards = self.acceptCreditCards;
    
    PayPalPaymentViewController *paymentViewController = [[PayPalPaymentViewController alloc] initWithPayment:payment
                                                                                                configuration:self.paypalConfig
                                                                                                     delegate:self];
    [self presentViewController:paymentViewController animated:YES completion:nil];

}
#pragma mark PayPalPaymentDelegate methods

- (void)payPalPaymentViewController:(PayPalPaymentViewController *)paymentViewController didCompletePayment:(PayPalPayment *)completedPayment {
    NSLog(@"PayPal Payment Success!");
    self.resultText = [completedPayment description];
    
 
    [self sendCompletedPaymentToServer:completedPayment]; // Payment was processed successfully; send to server for verification and fulfillment
    [self dismissViewControllerAnimated:YES completion:nil];
}

-(void)payPalPaymentDidCancel:(PayPalPaymentViewController *)paymentViewController
{
    NSLog(@"PayPal Payment Canceled");
    [self dismissViewControllerAnimated:YES completion:nil];
}

#pragma mark Proof of payment validation 验证

- (void)sendCompletedPaymentToServer:(PayPalPayment *)completedPayment {
    // TODO: Send completedPayment.confirmation to server
    NSLog(@"Here is your proof of payment:\n\n%@\n\nSend this to your server for confirmation and fulfillment.", completedPayment.confirmation);
}

//#pragma mark - PayPalPaymentDelegate methods
//
//
//-(void)payPalPaymentViewController:(PayPalPaymentViewController *)paymentViewController willCompletePayment:(PayPalPayment *)completedPayment completionBlock:(PayPalPaymentDelegateCompletionBlock)completionBlock
//{
//    
//}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

@end
