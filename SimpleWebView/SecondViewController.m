//
//  SecondViewController.m
//  SimpleWebView
//
//  Created by Сергей on 11/21/17.
//  Copyright © 2017 home. All rights reserved.
//

#import "SecondViewController.h"
#import "AppDelegate.h"

@interface SecondViewController ()<UITextFieldDelegate>
@property (nonatomic, weak) IBOutlet UITextField* textField;
@property (nonatomic, weak) IBOutlet UIButton* cancelButton;
@property (nonatomic, copy) NSString* currentURL;
@end

@implementation SecondViewController

- (void)viewDidLoad {
  [super viewDidLoad];
  // Do any additional setup after loading the view, typically from a nib.
}

- (void)viewWillAppear:(BOOL)animated
{
  [super viewWillAppear:animated];
  self.currentURL = [UIApplication sharedApplication].appDelegate.defaultURL.absoluteString;
  self.textField.text = self.currentURL;
}


- (void)didReceiveMemoryWarning {
  [super didReceiveMemoryWarning];
  // Dispose of any resources that can be recreated.
}

- (IBAction)cancelAction:(id)sender
{
  self.textField.text = self.currentURL;
  [self.textField resignFirstResponder];
}

- (void)textFieldDidBeginEditing:(UITextField *)textField
{
  self.cancelButton.hidden = true;
}

- (BOOL)textField:(UITextField *)textField shouldChangeCharactersInRange:(NSRange)range replacementString:(NSString *)string
{
  NSString* str = [textField.text stringByReplacingCharactersInRange:range withString:string];
  self.cancelButton.hidden = [str isEqualToString:self.currentURL];
  return true;
}

- (BOOL)textFieldShouldReturn:(UITextField *)textField
{
  NSURL* url = [NSURL URLWithString:textField.text];
  if(url)
  {
    [UIApplication sharedApplication].appDelegate.defaultURL = url;
    self.currentURL = textField.text;
    [textField resignFirstResponder];
    return true;
  }
  UIAlertController* alert = [UIAlertController alertControllerWithTitle:@"Error" message:@"Incorrect url" preferredStyle:UIAlertControllerStyleAlert];
  [alert addAction:[UIAlertAction actionWithTitle:@"OK" style:UIAlertActionStyleCancel handler:nil]];
  [self presentViewController:alert animated:true completion:nil];
  return false;
}
@end
